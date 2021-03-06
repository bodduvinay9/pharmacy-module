package org.openmrs.module.pharmacy.web.controller;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.openmrs.Role;
import org.openmrs.api.context.Context;
import org.openmrs.api.context.UserContext;
import org.openmrs.module.pharmacy.model.*;
import org.openmrs.module.pharmacy.service.PharmacyService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;
import java.util.List;

@Controller
public class DrugExtraController {
    private static final Log log = LogFactory.getLog(DrugExtraController.class);
    private JSONArray drugStrengthA;
    public PharmacyService service;
    private boolean found = false;
    private JSONArray drugExtraProperties;
    private UserContext userService;
    private boolean editPharmacy = false;
    private boolean deletePharmacy = false;
    private JSONArray datad2;
    private JSONObject jsonObject;
    private List<PharmacyEncounter> encountersList;
    private int size;
    private JSONArray jsonArray;
    private DrugExtra pharmacySupplier1;
    @RequestMapping(method = RequestMethod.GET, value = "module/pharmacy/revolveAdult")
    public synchronized void pageLoad(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        userService = Context.getUserContext();
        String sDate  = request.getParameter("datefrom");
        String eDate = request.getParameter("dateto");
        String uuid = request.getParameter("nameuuid");
        String drop = request.getParameter("drop");
        service = Context.getService(PharmacyService.class);
        String locationVal = null;
        List<PharmacyLocationUsers> listUsers = service.getPharmacyLocationUsersByUserName(Context.getAuthenticatedUser().getUsername());
        int sizeUsers = listUsers.size();
        if (sizeUsers > 1) {
            locationVal = request.getSession().getAttribute("location").toString();

        } else if (sizeUsers == 1) {
            locationVal = listUsers.get(0).getLocation();

        }
        SimpleDateFormat formatter = new SimpleDateFormat("MM/dd/yyyy");
        Date minDate = null;
        Date maxDate=null;
        try {
            minDate = formatter.parse(sDate);
            maxDate = formatter.parse(eDate);
        } catch (ParseException e) {
            e.printStackTrace();  //To change body of catch statement use File | Settings | File Templates.
        }
        PharmacyLocations locationInstance=service.getPharmacyLocationsByName(locationVal);
        encountersList = service.getDetailedEncountersRange(minDate,maxDate,locationInstance.getUuid());
        size = encountersList.size();
        jsonObject = new JSONObject();

        try {
            for(PharmacyEncounter encounterInstance:encountersList){
                List<PharmacyOrders> pharmacyOrders=service.getPharmacyOrdersByEncounterId(encounterInstance);
                String drugsIssuedToPatient="";
                Double cashWaived=0.0;
                Double cashDiscounted=0.0;
                List<DrugExtra> drugExtraList=service.getUnprocessedReceiptsByEncounterUUID(encounterInstance.getUuid());
                for(DrugExtra drugExtra:drugExtraList){
                    cashWaived=cashWaived+drugExtra.getAmountw();
                    cashDiscounted=cashDiscounted+drugExtra.getDiscount();
                }
                for (PharmacyOrders orderInstance:pharmacyOrders)
                {
                    if(orderInstance.getConcept() !=null)
                    {
                        List<PharmacyObs> listObsConcepts =service.getPharmacyObsByPharmacyOrder(orderInstance);
                        int lastItem=listObsConcepts.size()-1;
                        for (int y = 0; y < listObsConcepts.size(); y++)
                        {
                            if(y==lastItem)
                            {
                                drugsIssuedToPatient=drugsIssuedToPatient +listObsConcepts.get(y).getValue_drug().getName().toString() ;
                            }
                            else
                            {
                                drugsIssuedToPatient=drugsIssuedToPatient +listObsConcepts.get(y).getValue_drug().getName().toString()+", " ;
                            }

                        }
                    }
                }

                jsonArray = new JSONArray();
                jsonArray.put(""+encounterInstance.getPerson().getPatientId());
                jsonArray.put(""+encounterInstance.getPerson().getPatientIdentifier());
                jsonArray.put(drugsIssuedToPatient);
                jsonArray.put(cashWaived);
                jsonArray.put(cashDiscounted);
                jsonArray.put(encounterInstance.getCreator());
                jsonArray.put(""+encounterInstance.getDateCreated());
                jsonObject.accumulate("aaData",jsonArray);

            }
            jsonObject.accumulate("iTotalRecords", jsonObject.getJSONArray("aaData").length());
            jsonObject.accumulate("iTotalDisplayRecords", jsonObject.getJSONArray("aaData").length());
            jsonObject.accumulate("iDisplayStart", 0);
            jsonObject.accumulate("iDisplayLength", 10);
            response.getWriter().print(jsonObject);
            response.flushBuffer();

        } catch (Exception e) {
            // TODO Auto-generated catch block
            log.error("Error generated", e);
        }
    }
    public  Date fromSubmitString2Date(String date) throws ParseException {
        SimpleDateFormat dateFormat = new SimpleDateFormat("mm/dd/yyyy");
        return dateFormat.parse(date);
    }
    @RequestMapping(method = RequestMethod.POST, value = "module/pharmacy/revolveAdult")
    public synchronized void pageLoadd(HttpServletRequest request, HttpServletResponse response) throws ParseException {
        String locationVal = null;
        service = Context.getService(PharmacyService.class);
        List<PharmacyLocationUsers> listUsers = service.getPharmacyLocationUsersByUserName(Context.getAuthenticatedUser().getUsername());
        int sizeUsers = listUsers.size();
        if (sizeUsers > 1) {
            locationVal = request.getSession().getAttribute("location").toString();

        } else if (sizeUsers == 1) {
            locationVal = listUsers.get(0).getLocation();
        }

    }

    public synchronized JSONArray getArray(List<DrugExtra> drugExtra, int size,String val) throws JSONException {
        drugExtraProperties = new JSONArray();
        //int quant=findDrugQuantity(drugExtra.get(size).getDrug().getDrugId(),val);
        drugExtraProperties.put(drugExtra.get(size).getPatientId());
        drugExtraProperties.put(drugExtra.get(size).getPatientId());
        drugExtraProperties.put(drugExtra.get(size).getPatientId());
        drugExtraProperties.put(drugExtra.get(size).getPatientId());
        drugExtraProperties.put(drugExtra.get(size).getPatientId());
        drugExtraProperties.put(drugExtra.get(size).getPatientId());
        drugExtraProperties.put(drugExtra.get(size).getPatientId());
        return drugExtraProperties;
    }

    public synchronized int getDropDown(List<DrugExtra> supplierNamee, int size) {

        return supplierNamee.get(size).getReceipt();
    }

    public synchronized boolean getCheck(List<DrugExtra> supplierNamee, int size, String names) {


            return true;



    }
  /*  public Integer  getDrugQuantity(int drugId,String val){


        List<DrugDispenseSettings> list = service.getDrugDispenseSettings();

        int size = list.size();
        int quantity=0;
        for (int i = 0; i < size; i++) {

            if(list.get(i).getLocation().getName().equalsIgnoreCase(val)){
//                PharmacyStore pharmacyStore=   service.getDrugDispenseSettingsByDrugId(Context.getConceptService().getDrugByNameOrId(""+drugId)).getInventoryId();
                PharmacyStore pharmacyStore=   list.get(i).getInventoryId();


                if(pharmacyStore!=null ){

                    if(pharmacyStore.getDrugs().getDrugId()==drugId){

                       quantity= pharmacyStore.getQuantity();

                    }
                }
            }
        }

        return quantity;
    }
  */
  public Integer  findDrugQuantity(int drugId,String val){
      List<DrugDispenseSettings> list = service.getDrugDispenseSettings();
       int quantity=0;
      int size = list.size();
      for (int i = 0; i < size; i++) {

          if(list.get(i).getLocation().getName().equalsIgnoreCase(val)){
//                PharmacyStore pharmacyStore=   service.getDrugDispenseSettingsByDrugId(Context.getConceptService().getDrugByNameOrId(""+drugId)).getInventoryId();
              PharmacyStore pharmacyStore=   list.get(i).getInventoryId();


              if(pharmacyStore!=null ){

                  if(pharmacyStore.getDrugs().getDrugId()==drugId){


                      quantity= pharmacyStore.getQuantity();


                  }
              }
          }
      }

      return quantity;
  }
}
