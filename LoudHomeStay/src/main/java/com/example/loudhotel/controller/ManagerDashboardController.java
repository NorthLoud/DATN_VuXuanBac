package com.example.loudhotel.controller;

import com.example.loudhotel.dto.response.DashboardDTO;
import com.example.loudhotel.service.ManagerDashboardService;
import com.example.loudhotel.utils.SecurityUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/manager/dashboard")
@RequiredArgsConstructor
public class ManagerDashboardController {

    private final ManagerDashboardService dashboardService;
}