package com.leoman.house.controller;

import com.leoman.common.controller.common.GenericEntityController;
import com.leoman.common.core.Result;
import com.leoman.common.factory.DataTableFactory;
import com.leoman.common.service.Query;
import com.leoman.entity.Configue;
import com.leoman.house.entity.*;
import com.leoman.house.service.HouseAlbumImageService;
import com.leoman.house.service.HouseAlbumService;
import com.leoman.house.service.HouseDynamicService;
import com.leoman.house.service.HouseService;
import com.leoman.house.service.impl.HouseAlbumServiceImpl;
import com.leoman.house.service.impl.HouseServiceImpl;
import com.leoman.image.entity.Image;
import com.leoman.image.service.UploadImageService;
import com.leoman.utils.DateUtils;
import com.leoman.utils.JsonUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 楼层相册管理
 * Created by Daisy on 2016/10/14.
 */
@Controller
@RequestMapping(value = "admin/house/album")
public class HouseAlbumController extends GenericEntityController<HouseAlbum,HouseAlbum,HouseAlbumServiceImpl> {

    @Autowired
    private HouseAlbumService houseAlbumService;

    @Autowired
    private HouseAlbumImageService houseAlbumImageService;

    @Autowired
    private UploadImageService uploadImageService;

    @Autowired
    private HouseService houseService;


    /**
     * 跳转编辑相册页面
     * @param id
     * @param model
     * @return
     */
    @RequestMapping(value = "/edit/{id}")
    public String editAlbum(@PathVariable("id") Long id, Model model){
        model.addAttribute("houseId", id);
        return "house/house_edit_album";
    }

    /**
     * 跳转编辑相册页面
     * @param model
     * @return
     */
    @RequestMapping(value = "/editImage/{houseId}_{albumId}")
    public String editAlbumImage(@PathVariable("houseId") Long houseId,@PathVariable("albumId") Long albumId, Model model){

        HouseAlbum album = houseAlbumService.queryByPK(albumId);
        model.addAttribute("album",album);

        House house = houseService.queryByPK(houseId);
        model.addAttribute("house",house);
        return "house/house_edit_album_image";
    }

    /**
     * 列表
     * @return
     */
    @RequestMapping(value = "/list", method = RequestMethod.POST)
    @ResponseBody
    public Result list(Long houseId) {
        List<HouseAlbum> list = houseAlbumService.queryAll();
        for (HouseAlbum ha:list) {
            List<HouseAlbumImage> imageList = houseAlbumImageService.findImageNum(houseId, ha.getId());
            ha.setImageNum(imageList==null?0l:imageList.size());
            if(imageList != null && imageList.size() > 0){
                Image image = imageList.get(0).getImage();
                ha.setCoverUrl(Configue.getUploadUrl() + image.getPath());
            }
        }

        return new Result().success(createMap("list",list));
    }

    /**
     * 保存楼盘相册
     * @return
     */
    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public Result save(HouseAlbumImage albumImage) {

        houseAlbumImageService.save(albumImage);
        return Result.success();
    }

    /**
     * 删除
     * @return
     */
    @RequestMapping(value = "/delete", method = RequestMethod.POST)
    @ResponseBody
    public Result delete(String ids) {

        String[] idArr = JsonUtil.json2Obj(ids,String[].class);
        for (String id : idArr) {
            if(StringUtils.isNotEmpty(id)){
                houseAlbumImageService.deleteByPK(Long.valueOf(id));
            }
        }

        return new Result().success();
    }

    /**
     * 列表
     * @return
     */
    @RequestMapping(value = "/imageList", method = RequestMethod.POST)
    @ResponseBody
    public Result imageList(Long houseId, Long albumId) {
        List<HouseAlbumImage> list = houseAlbumImageService.findImageNum(houseId, albumId);
        for (HouseAlbumImage hai:list) {
            if(hai.getImage() != null){
                hai.getImage().setPath(Configue.getUploadUrl() + hai.getImage().getPath());
            }
        }

        return new Result().success(createMap("list",list));
    }

    @RequestMapping(value = "/saveImage", method = RequestMethod.POST)
    @ResponseBody
    public Result saveImage(HouseAlbumImage albumImage, MultipartRequest multipartRequest) {

        List<MultipartFile> files = multipartRequest.getFiles("file");
        if(files != null){
            for (MultipartFile file:files) {
                HouseAlbumImage hai = new HouseAlbumImage();
                hai.setAlbum(albumImage.getAlbum());
                hai.setHouseId(albumImage.getHouseId());
                Image image = uploadImageService.uploadImage(file);
                hai.setImage(image);
                houseAlbumImageService.save(hai);
            }
        }

        return Result.success();
    }


}
