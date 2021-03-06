package com.leoman.house.entity;

import com.leoman.entity.BaseEntity;
import com.leoman.image.entity.Image;

import javax.persistence.*;

/**
 * 楼盘的每一栋的每一层
 * Created by Daisy on 2016/10/18.
 */
@Entity
@Table(name = "t_house_ridgepole_floor")
public class HouseRidgepoleFloor extends BaseEntity{

    @ManyToOne
    @JoinColumn(name = "ridgepole_id")
    private HouseRidgepole ridgepole;//所在栋

    @Column(name = "floor_no")
    private Long floorNo;//楼层编号

    @ManyToOne
    @JoinColumn(name = "floor_type_id")
    private HouseFloorType floorType;//楼层类型

    @ManyToOne
    @JoinColumn(name = "direction_image_id")
    private Image directionImage;//方位图

    public HouseRidgepole getRidgepole() {
        return ridgepole;
    }

    public void setRidgepole(HouseRidgepole ridgepole) {
        this.ridgepole = ridgepole;
    }

    public Long getFloorNo() {
        return floorNo;
    }

    public void setFloorNo(Long floorNo) {
        this.floorNo = floorNo;
    }

    public HouseFloorType getFloorType() {
        return floorType;
    }

    public void setFloorType(HouseFloorType floorType) {
        this.floorType = floorType;
    }

    public Image getDirectionImage() {
        return directionImage;
    }

    public void setDirectionImage(Image directionImage) {
        this.directionImage = directionImage;
    }
}
