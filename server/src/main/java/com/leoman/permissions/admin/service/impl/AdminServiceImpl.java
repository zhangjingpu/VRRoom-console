package com.leoman.permissions.admin.service.impl;

import com.leoman.common.core.Result;
import com.leoman.pay.util.MD5Util;
import com.leoman.permissions.admin.dao.AdminDao;
import com.leoman.permissions.admin.entity.Admin;
import com.leoman.permissions.admin.service.AdminService;
import com.leoman.common.service.impl.GenericManagerImpl;
import com.leoman.permissions.adminrole.entity.AdminRole;
import com.leoman.permissions.adminrole.service.AdminRoleService;
import com.leoman.enterprise.service.EnterpriseService;
import com.leoman.user.entity.UserInfo;
import com.leoman.user.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.Transient;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2016/3/8.
 */
@Service
public class AdminServiceImpl extends GenericManagerImpl<Admin, AdminDao> implements AdminService {

    @Autowired
    private AdminDao adminDao;

    @Autowired
    private AdminRoleService adminRoleService;

    @Autowired
    private UserService userService;

    @Autowired
    private EnterpriseService enterpriseService;

    @Override
    public Admin findByUsername(String username) {
        return adminDao.findByUsername(username);
    }

    @Override
    public Page<Admin> page(Integer pageNum, Integer pageSize) {
        PageRequest pageRequest = new PageRequest(pageNum - 1, pageSize, Sort.Direction.DESC, "id");
        Page<Admin> page = adminDao.findAll(new Specification<Admin>() {
            @Override
            public Predicate toPredicate(Root<Admin> root, CriteriaQuery<?> query, CriteriaBuilder cb) {
                Predicate result = null;
                List<Predicate> predicateList = new ArrayList<Predicate>();

                if (predicateList.size() > 0) {
                    result = cb.and(predicateList.toArray(new Predicate[]{}));
                }

                if (result != null) {
                    query.where(result);
                }
                return query.getGroupRestriction();
            }

        }, pageRequest);

        return page;
    }

    @Override
    @Transient
    public Result save(Admin admin, Long enterpriseId, Long roleId) {
        admin.setLastLoginDate(System.currentTimeMillis());
        AdminRole adminRole = new AdminRole();
        UserInfo userInfo = new UserInfo();
        try {
            admin.setPassword(MD5Util.MD5Encode(admin.getPassword(),"UTF-8"));

            /*if(enterpriseId!=null){
                Enterprise enterprise = enterpriseService.queryByPK(enterpriseId);
                admin.setEnterprise(enterprise);
            }*/

            save(admin);

            //关联角色
            adminRole.setAdminId(admin.getId());
            adminRole.setRoleId(roleId);
            List<AdminRole> adminRoles = adminRoleService.queryByProperty("adminId",admin.getId());
            if(!adminRoles.isEmpty() && adminRoles.size()>0){
                for(AdminRole a : adminRoles){
                    adminRoleService.delete(a);
                }
            }
            adminRoleService.save(adminRole);

            //新增一条企业管理员信息
            if(enterpriseId!=null){
                List<UserInfo> userInfos = userService.queryByProperty("userId",admin.getId());
                if(!userInfos.isEmpty() && userInfos.size()>0){
                    UserInfo _userInfo = userInfos.get(0);
                    _userInfo.setMobile(admin.getMobile());
//                    _userInfo.setPassword(admin.getPassword());
//                    _userInfo.setEnterprise(admin.getEnterprise());
                    userService.save(_userInfo);
                }else {
                    userInfo.setUserId(admin.getId());
                    userInfo.setMobile(admin.getMobile());
//                    userInfo.setPassword(admin.getPassword());
//                    userInfo.setEnterprise(admin.getEnterprise());
                    userInfo.setType(0);
                    userService.save(userInfo);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            Result.failure();
        }
        return Result.success();
    }



}
