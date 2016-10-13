package com.leoman.house.controller;

import com.leoman.common.controller.common.GenericEntityController;
import com.leoman.common.core.Result;
import com.leoman.common.factory.DataTableFactory;
import com.leoman.common.service.Query;
import com.leoman.house.entity.House;
import com.leoman.house.entity.HouseUnit;
import com.leoman.house.service.HouseDynamicService;
import com.leoman.house.service.HouseService;
import com.leoman.house.service.HouseUnitService;
import com.leoman.house.service.impl.HouseServiceImpl;
import com.leoman.image.entity.Image;
import com.leoman.image.service.UploadImageService;
import com.leoman.utils.JsonUtil;
import com.leoman.utils.UploadUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import java.util.List;
import java.util.Map;

/**
 * 楼层户型管理
 * Created by Daisy on 2016/10/13.
 */
@Controller
@RequestMapping(value = "admin/house/unit")
public class HouseUnitController extends GenericEntityController<House,House,HouseServiceImpl> {

    @Autowired
    private HouseService houseService;

    @Autowired
    private HouseUnitService houseUnitService;

    @Autowired
    private UploadImageService uploadImageService;

    @RequestMapping(value = "/index")
    public String index(){
        return "house/house_list";
    }

    /**
     * 列表
     * @return
     */
//    @RequestMapping(value = "/list", method = RequestMethod.POST)
//    @ResponseBody
//    public Map<String, Object> list(Integer draw, Integer start, Integer length) {
//        int pagenum = getPageNum(start, length);
//        Query query = Query.forClass(HouseUnit.class, houseUnitService);
//        query.setPagenum(pagenum);
//        query.setPagesize(length);
//        Page<HouseUnit> page = houseUnitService.queryPage(query);
//        return DataTableFactory.fitting(draw, page);
//    }

    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public Result list() {
        List<HouseUnit> list = houseUnitService.findByHouseId(0l);
        return new Result().success(createMap("list",list));
    }

    /**
     * 跳转新增页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/add")
    public String add(Long id, Model model){
        if(id != null){
            House house = houseService.queryByPK(id);
            model.addAttribute("house", house);
        }
        return "house/house_add";
    }

    /**
     * 跳转编辑基本信息页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/edit")
    public String edit(Long id, Model model){
        if(id != null){
            House house = houseService.queryByPK(id);
            model.addAttribute("house", house);
        }
        return "house/house_edit";
    }

    /**
     * 跳转编辑楼盘户型页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/editUnit")
    public String editUnit(Long id, Model model){
        if(id != null){
            House house = houseService.queryByPK(id);
            model.addAttribute("house", house);
        }
        return "house/house_edit_unit";
    }

    /**
     * 保存新增的楼盘户型
     * @param houseUnit
     * @return
     */
    @RequestMapping(value = "/saveAdd", method = RequestMethod.POST)
    @ResponseBody
    public Result saveUnit(HouseUnit houseUnit, MultipartRequest multipartRequest) {

        MultipartFile planeFile = multipartRequest.getFile("planeFile");
        if (null != planeFile) {
            Image planeImage = uploadImageService.uploadImage(planeFile);
            houseUnit.setPlaneImage(planeImage);//平面图
        }

        MultipartFile d3File = multipartRequest.getFile("d3File");
        if (null != d3File) {
            Image d3Image = uploadImageService.uploadImage(d3File);
            houseUnit.setD3Image(d3Image);//3d图片
        }

        MultipartFile d3ModelRecogFile = multipartRequest.getFile("d3ModelRecogFile");
        if (null != d3ModelRecogFile) {
            String d3ModelRecogUrl = uploadImageService.uploadFile(d3ModelRecogFile);
            houseUnit.setD3ModelRecogUrl(d3ModelRecogUrl);//3D模型识别图
        }

        MultipartFile d3ModelFile = multipartRequest.getFile("d3ModelFile");
        if (null != d3ModelFile) {
            String d3ModelUrl = uploadImageService.uploadFile(d3ModelFile);
            houseUnit.setD3ModelUrl(d3ModelUrl);//3D模型
        }

        houseUnitService.save(houseUnit);
        return Result.success();
    }

    /**
     * 跳转编辑基本页面页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/editDynamic")
    public String editDynamic(Long id, Model model){
        if(id != null){
            House house = houseService.queryByPK(id);
            model.addAttribute("house", house);
        }
        return "house/house_edit_dynamic";
    }

    /**
     * 删除
     * @param id
     * @param ids
     * @return
     */
    @RequestMapping(value = "/del", method = RequestMethod.POST)
    @ResponseBody
    public Integer del(Long id,String ids) {
        if (id==null && StringUtils.isBlank(ids)){
            return 1;
        }
        try {
            if(id!=null){
                houseService.delete(houseService.queryByPK(id));
            }else {
                Long[] ss = JsonUtil.json2Obj(ids,Long[].class);
                for (Long _id : ss) {
                    houseService.delete(houseService.queryByPK(_id));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            return 1;
        }
        return 0;
    }


}
