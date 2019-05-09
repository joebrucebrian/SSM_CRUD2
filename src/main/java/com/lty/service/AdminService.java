package com.lty.service;

import com.lty.bean.Admin;
import com.lty.dao.AdminMapper;
import com.lty.utils.FunctionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AdminService {
    @Autowired
    AdminMapper adminMapper;

    public Admin getAdmin(String adminName) {
        return adminMapper.selectByName(adminName);
    }

    public Admin getAdmin(int adminId) {
        return adminMapper.selectByPrimaryKey(adminId);
    }
}
