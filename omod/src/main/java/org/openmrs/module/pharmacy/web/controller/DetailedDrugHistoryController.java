package org.openmrs.module.pharmacy.web.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.openmrs.*;
import org.openmrs.api.ConceptService;
import org.openmrs.api.LocationService;
import org.openmrs.api.context.Context;
import org.openmrs.api.context.UserContext;
import org.openmrs.module.pharmacy.model.*;
import org.openmrs.module.pharmacy.service.PharmacyService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.*;

import org.springframework.ui.ModelMap;

@Controller
public class DetailedDrugHistoryController{
    private static  final Log log=LogFactory.getLog(DetailedDrugHistoryController.class);
    public PharmacyService service;


    @RequestMapping(method=RequestMethod.GET,value="module/pharmacy/resources/subpages/detailedDrugHistory")
    public void displayComprehensiveRFPReport(ModelMap map,HttpServletRequest request) throws java.text.ParseException, IOException {

        String drugId=request.getParameter("drugID");
        request.getSession().setAttribute("sessionDrugId", drugId);
    }

}
