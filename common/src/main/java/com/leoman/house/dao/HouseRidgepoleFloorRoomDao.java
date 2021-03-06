package com.leoman.house.dao;

import com.leoman.common.dao.IBaseJpaRepository;
import com.leoman.house.entity.HouseRidgepoleFloor;
import com.leoman.house.entity.HouseRidgepoleFloorRoom;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 楼盘的每一栋的每一层的每一个房间
 * Created by Daisy on 2016/10/18.
 */
public interface HouseRidgepoleFloorRoomDao extends IBaseJpaRepository<HouseRidgepoleFloorRoom> {

    @Query("select a from HouseRidgepoleFloorRoom a where a.ridgepoleFloor.ridgepole.id = ?1")
    public List<HouseRidgepoleFloorRoom> findByRidgepoleId(Long ridgepoleId);

}
