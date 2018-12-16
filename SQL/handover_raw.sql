select 
to_char(sysdate,'YYYYMMDDHH24MI') 查询时间,
enb_id,
enb_cell,
bts_version,
ip,
切换成功率ZB, 
切换成功率QQ,
切换成功次数,
切换失败次数QQ,
切换失败次数ZB,
切换请求次数ZB,
切换请求次数QQ,
PUSCH_RIP,
mtIntereNBHo_8014,
mtIntraeNBHo_8009
from
(
SELECT
--substr(sdate,1,10)*100+to_char(trunc(to_number(substr(sdate,11,2)/15))*15,'00') sdate,
--substr(sdate,1,8) sdate,
enb_cell,enb_id,bts_version,cel_name


,Round(Decode(sum(M8009C6 + M8014C0 + M8014C14),0,0,100* sum(M8009C7 + M8014C7 + M8014C19) / sum(M8009C6 + M8014C0 + M8014C14)),2) 切换成功率ZB 
,Round(Decode(sum(M8009C6 + M8014C6 + M8014C18),0,0,100* sum(M8009C7 + M8014C7 + M8014C19) / sum(M8009C6 + M8014C6 + M8014C18)),2) 切换成功率QQ
,sum(M8009C7 + M8014C7 + M8014C19) 切换成功次数 
,sum(M8009C6 + M8014C6 + M8014C18)-sum(M8009C7 + M8014C7 + M8014C19) 切换失败次数QQ
,sum(M8009C6 + M8014C0 + M8014C14)-sum(M8009C7 + M8014C7 + M8014C19) 切换失败次数ZB
,sum(M8009C6 + M8014C0 + M8014C14) 切换请求次数ZB 
,sum(M8009C6 + M8014C6 + M8014C18) 切换请求次数QQ
,Round((avg(M8005C5)-avg(M8005C95)),2) PUSCH_RIP

FROM
(
SELECT comm.sdate
          --   ,M8020.MRBTS_ID
         --    ,M8020.LNBTS_ID
         --    ,M8020.LNCEL_ID
     ,enb_id || '_' || cell_id enb_cell
     ,enb_id,
         case  when ((enb_id>=655360 and enb_id<=656383 ) or (enb_id>= 686080 and enb_id<=686591 ) or (enb_id>= 696320 and enb_id<=696831 )or (enb_id>= 119296 and enb_id<=120831 )) then 'ZhanJiang'
              when ((enb_id>=656384 and enb_id<=657151 ) or (enb_id>= 683520 and enb_id<=683775 ) or (enb_id>= 698880 and enb_id<=699647 ) or (enb_id>= 711168and enb_id<=712191 ))then 'MaoMing'
              when ((enb_id>=659712 and enb_id<=660223 ) or (enb_id >= 684032 and enb_id <=684287 ) or(enb_id>= 701184 and enb_id<=701951 ) or (enb_id>= 716800 and enb_id<=717055 ) or (enb_id >=822528 and enb_id <=823807) or (enb_id >=201728 and enb_id <=201983) or (enb_id >=837888 and enb_id <=838399) or (enb_id >=340736 and enb_id <=341247)or (enb_id >=561920 and enb_id <=562431)) then 'ChaoZhou'
              when ((enb_id>=660736 and enb_id<=661247 ) or (enb_id >= 683776 and enb_id <=684031 ) or(enb_id>= 702464 and enb_id<=703487 ) ) then 'MeiZhou'
              when ((enb_id>=662272 and enb_id<=662783 ) or (enb_id>= 704000 and enb_id<=704511 ) or (enb_id >=719616 and enb_id <=720127)) then 'YangJiang'
              else 'NA'      
        end City
       
,cell_id
--,bts_ip
,bts_version
--,bts_name
,cel_name
,M8005C5,M8005C54,M8005C55,M8005C56,M8005C57,M8005C58,M8005C59,M8005C60,M8005C61,M8005C62,M8005C63,M8005C64,M8005C65,M8005C66,M8005C67,M8005C68,M8005C69,M8005C70,M8005C71,M8005C72,M8005C73,M8005C74,M8005C75,M8005C76,M8005C77,M8005C78,M8005C79,M8005C80,M8005C81,M8005C82,M8005C83,M8005C84,M8005C85,M8005C87,M8005C88,M8005C89,M8005C95,M8009C15,M8009C16,M8009C6,M8009C7,M8014C0,M8014C14,M8014C18,M8014C19,M8014C23,M8014C24,M8014C26,M8014C27,M8014C6,M8014C7
 
 
FROM


( select
             to_char(period_start_time,'yyyymmddHH24MI') sdate
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,AVG(DECODE(RSSI_PUSCH_AVG,0,NULL,RSSI_PUSCH_AVG)) M8005C5 --The Received Signal Strength Indicator (RSSI) Mean value for PUSCH, measured in the eNB.
,avg(SINR_PUSCH_AVG) M8005C95 --The Signal to Interference and Noise Ratio (SINR) Mean value for PUSCH, measured in the eNB.
,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL1,0)) M8005C54    --The UE Power Headroom values in the range of -23dB <= PHR < -21dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL2,0)) M8005C55    --The UE Power Headroom values in the range of -21dB <= PHR < -19dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL3,0)) M8005C56    --The UE Power Headroom values in the range of -19dB <= PHR < -17dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL4,0)) M8005C57    --The UE Power Headroom values in the range of -17dB <= PHR < -15dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL5,0)) M8005C58    --The UE Power Headroom values in the range of -15dB <= PHR < -13dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL6,0)) M8005C59    --The UE Power Headroom values in the range of -13dB <= PHR < -11dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL7,0)) M8005C60    --The UE Power Headroom values in the range of -11dB <= PHR < -9dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL8,0)) M8005C61    --The UE Power Headroom values in the range of -9dB <= PHR < -7dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL9,0)) M8005C62    --The UE Power Headroom values in the range of -7dB <= PHR < -5dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL10,0)) M8005C63    --The UE Power Headroom values in the range of -5dB <= PHR < -3dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL11,0)) M8005C64    --The UE Power Headroom values in the range of -3dB <= PHR < -1dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL12,0)) M8005C65    --The UE Power Headroom values in the range of -1dB <= PHR < 1dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL13,0)) M8005C66    --The UE Power Headroom values in the range of 1dB <= PHR < 3dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL14,0)) M8005C67    --The UE Power Headroom values in the range of 3dB <= PHR < 5dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL15,0)) M8005C68    --The UE Power Headroom values in the range of 5dB <= PHR < 7dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL16,0)) M8005C69    --The UE Power Headroom values in the range of 7dB <= PHR < 9dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL17,0)) M8005C70    --The UE Power Headroom values in the range of 9dB <= PHR < 11dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL18,0)) M8005C71    --The UE Power Headroom values in the range of 11dB <= PHR < 13dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL19,0)) M8005C72    --The UE Power Headroom values in the range of 13dB <= PHR < 15dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL20,0)) M8005C73    --The UE Power Headroom values in the range of 15dB <= PHR < 17dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL21,0)) M8005C74    --The UE Power Headroom values in the range of 17dB <= PHR < 19dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL22,0)) M8005C75    --The UE Power Headroom values in the range of 19dB <= PHR < 21dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL23,0)) M8005C76    --The UE Power Headroom values in the range of 21dB <= PHR < 23dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL24,0)) M8005C77    --The UE Power Headroom values in the range of 23dB <= PHR < 25dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL25,0)) M8005C78    --The UE Power Headroom values in the range of 25dB <= PHR < 27dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL26,0)) M8005C79    --The UE Power Headroom values in the range of 27dB <= PHR < 29dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL27,0)) M8005C80    --The UE Power Headroom values in the range of 29dB <= PHR < 31dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL28,0)) M8005C81    --The UE Power Headroom values in the range of 31dB <= PHR < 33dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL29,0)) M8005C82    --The UE Power Headroom values in the range of 33dB <= PHR < 35dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL30,0)) M8005C83    --The UE Power Headroom values in the range of 35dB <= PHR < 37dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL31,0)) M8005C84    --The UE Power Headroom values in the range of 37dB <= PHR < 39dB. Used for the UE Power Headroom PUSCH histogram.
      ,sum(nvl(UE_PWR_HEADROOM_PUSCH_LEVEL32,0)) M8005C85    --The UE Power Headroom values in the range of 39 dB <= PHR. Used for the UE Power Headroom PUSCH histogram.
      ,min(nvl(UE_PWR_HEADROOM_PUSCH_MIN,0)) M8005C87    --The UE Power Headroom for the PUSCH minimum value for the reporting period. To get actual dB value calculate: "counter value - 23" according to 3GPP 36.133 chapter 9.1.8.4.
      ,max(nvl(UE_PWR_HEADROOM_PUSCH_MAX,0)) M8005C88    --The UE Power Headroom for the PUSCH maximum value for the reporting period. To get actual dB value calculate: "counter value - 23" according to 3GPP 36.133 chapter 9.1.8.4.
      ,avg(nvl(UE_PWR_HEADROOM_PUSCH_AVG,0)) M8005C89    --The UE Power Headroom for the PUSCH mean value for the reporting period. To get actual dB value calculate: "counter value - 23" according to 3GPP 36.133 chapter 9.1.8.4.
,case when  avg(nvl(RSSI_PUSCH_AVG,0)) - avg(nvl(SINR_PUSCH_AVG,0)) > -105  and avg(nvl(RSSI_PUSCH_AVG,0)) - avg(nvl(SINR_PUSCH_AVG,0)) <> 0
      then 1
      else 0
 end interference105
,case when  avg(nvl(RSSI_PUSCH_AVG,0)) - avg(nvl(SINR_PUSCH_AVG,0)) > -110 and avg(nvl(RSSI_PUSCH_AVG,0)) - avg(nvl(SINR_PUSCH_AVG,0)) <> 0
      then 1
      else 0
 end interference110

FROM NOKLTE_PV_LPQUL_MNC1_raw PMRAW
        where

         period_start_time between to_date(to_char(sysdate-5/96,'YYYYMMDDHH24MI'),'yyyymmddHH24MI') and to_date(to_char(sysdate,'YYYYMMDDHH24MI'),'yyyymmddHH24MI')
         
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8005
,(
select
             to_char(period_start_time,'yyyymmddHH24MI') sdate
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,sum(nvl(ATT_INTRA_ENB_HO,0)) M8009C6 --The number of Intra-eNB Handover attempts.
,sum(nvl(SUCC_INTRA_ENB_HO,0)) M8009C7 --The number of successful Intra-eNB Handover completions.
,sum(nvl(INTRA_ENB_HO_QCI1_ATT,0)) M8009C15
,sum(nvl(INTRA_ENB_HO_QCI1_SUCC,0)) M8009C16


        from
             NOKLTE_PS_LIANBHO_MNC1_raw PMRAW
        where
         period_start_time between to_date(to_char(sysdate-5/96,'YYYYMMDDHH24MI'),'yyyymmddHH24MI') and to_date(to_char(sysdate,'YYYYMMDDHH24MI'),'yyyymmddHH24MI')
            --- to_char(period_start_time,'yyyymmddHH24MI') >= to_char(SYSDATE-1,'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8009,(
select
             to_char(period_start_time,'yyyymmddHH24MI') sdate
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,sum(nvl(INTER_ENB_HO_PREP,0)) M8014C0 --The number of Inter-eNB X2-based Handover preparations. The Mobility management (MM) receives a list with target cells from the RRM and decides to start an Inter-eNB X2-based Handover.
,sum(nvl(INTER_ENB_S1_HO_PREP,0)) M8014C14 --The number of Inter eNB S1-based Handover preparations
,sum(nvl(INTER_ENB_S1_HO_ATT,0)) M8014C18 --The number of Inter eNB S1-based Handover attempts
,sum(nvl(INTER_ENB_S1_HO_SUCC,0)) M8014C19 --The number of successful Inter eNB S1-based Handover completions
,sum(nvl(ATT_INTER_ENB_HO,0)) M8014C6 --The number of Inter-eNB X2-based Handover attempts.
,sum(nvl(SUCC_INTER_ENB_HO,0)) M8014C7 --The number of successful Inter-eNB X2-based Handover completions.
,sum(nvl(INTER_ENB_S1_HO_QCI1_ATT,0)) M8014C23
,sum(nvl(INTER_ENB_S1_HO_QCI1_SUCC,0)) M8014C24
,sum(nvl(INTER_ENB_X2_HO_QCI1_ATT,0)) M8014C26
,sum(nvl(INTER_ENB_X2_HO_QCI1_SUCC,0)) M8014C27


        from
             NOKLTE_PS_LIENBHO_MNC1_raw PMRAW
        where
        
        period_start_time between to_date(to_char(sysdate-5/96,'YYYYMMDDHH24MI'),'yyyymmddHH24MI') and to_date(to_char(sysdate,'YYYYMMDDHH24MI'),'yyyymmddHH24MI')
            -- to_char(period_start_time,'yyyymmddHH24MI')  >= to_char(SYSDATE-1,'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8014,
(
select
to_char(period_start_time,'yyyymmddHH24MI') sdate
,LNCEL_ID
,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,lnbts.co_object_instance enb_id
,lncel.co_object_instance cell_id
--,lnbts.co_main_host bts_ip
,lnbts.co_sys_version bts_version
,Trim(lnbts.co_name) bts_name
,Trim(lncel.co_name) cel_name  
from
(
Select Distinct * from 
(
Select lnbts_id,lncel_id,period_start_time from NOKLTE_PS_LRDB_MNC1_RAW m8007
Union
Select lnbts_id,lncel_id,period_start_time from NOKLTE_PS_LCELAV_MNC1_RAW m8020
)
) comm,
ctp_common_objects lnbts,
ctp_common_objects lncel
where 
comm.period_start_time between to_date(to_char(sysdate-5/96,'YYYYMMDDHH24MI'),'yyyymmddHH24MI') and to_date(to_char(sysdate,'YYYYMMDDHH24MI'),'yyyymmddHH24MI')
and comm.lnbts_id=lnbts.co_gid
AND comm.LNCEL_ID=lncel.co_gid
AND lnbts.CO_STATE<>9 
AND lncel.CO_STATE<>9
) comm
WHERE      comm.cel_key_id=m8005.cel_key_id(+)
       AND comm.cel_key_id=m8009.cel_key_id(+)
       AND comm.cel_key_id=m8014.cel_key_id(+)

)
WHERE  enb_id between '0' and '999999'  
--and enb_id in ('701208')
/*
AND ((enb_id >=659712 and enb_id <=660223) 
        or (enb_id >=684032 and enb_id <=684287)
        or (enb_id >=701184 and enb_id <=701439) 
        or (enb_id >=701440 and enb_id <=701951)
        or (enb_id >=716800 and enb_id <=717055)
        or (enb_id >=201728 and enb_id <=201983)
        or (enb_id >=822528 and enb_id <=823807)
        or (enb_id >=837888 and enb_id <=838399)
        or (enb_id >=340736 and enb_id <=341247)
        )
*/
GROUP BY 
--substr(sdate,1,10)*100+to_char(trunc(to_number(substr(sdate,11,2)/15))*15,'00'),
substr(sdate,1,8),
enb_cell,enb_id,bts_version,cel_name
) kpi 
left join
(
select BTS.CO_OBJECT_INSTANCE enb_id_pm,
       --BTS.CO_NAME bts_name,
       --BTS.CO_SYS_VERSION  BTS_VERSION,
       em.em_host_name IP,
       decode(PMRNL_MCA_1,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MCA_1) mtCellAvailability_8020,
       decode(PMRNL_MT_CELL_LOAD,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_CELL_LOAD) mtCellLoad_8001,
       decode(PMRNL_MT_CELL_RES,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_CELL_RES) mtCellRes_8011,
       decode(PMRNL_MT_CELL_THRUPUT,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_CELL_THRUPUT) mtCellThruput_8012,
       decode(PMRNL_MT_EPS_BEARER,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_EPS_BEARER) mtEPSBearer_8006,
       decode(PMRNL_MEFU_31,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MEFU_31) mtEutraFrequency_8034,
       decode(PMRNL_MT_HO_RLF,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_HO_RLF) mtHoRlf_8027,
       decode(PMRNL_MT_INTER_SYS_HO,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_INTER_SYS_HO) mtInterSysHo_8016,
       decode(PMRNL_MISHEB_7,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MISHEB_7) mtInterSysHoEhrpdBc_8025,
       decode(PMRNL_MISHGN_7,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MISHGN_7) mtInterSysHoGsmNb_8019,
       decode(PMRNL_MISHUN_8,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MISHUN_8) mtInterSysHoUtranNb_8017,
       decode(PMRNL_MT_INTERE_NB_HO,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_INTERE_NB_HO) mtIntereNBHo_8014,
       decode(PMRNL_MT_INTRAE_NB_HO,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_INTRAE_NB_HO) mtIntraeNBHo_8009,
       decode(PMRNL_MT_LTE_HO,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_LTE_HO) mtLTEHo_8021,
       decode(PMRNL_MM3SS_32,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MM3SS_32) mtM3SctpStatistics_8037,
       decode(PMRNL_MT_MAC,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_MAC) mtMAC_8029,
       decode(PMRNL_MT_MBMS,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_MBMS) mtMBMS_8030,
       decode(PMRNL_MT_MOB_EVENTS,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_MOB_EVENTS) mtMobilityEvents_8033,
       decode(PMRNL_MMUFU_16,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MMUFU_16) mtMroUtranFrequency_8032,
       decode(PMRNL_MT_POW_QUAL_DL,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_POW_QUAL_DL) mtPowQualDL_8010,
       decode(PMRNL_MT_POW_QUAL_UL,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_POW_QUAL_UL) mtPowQualUL_8005,
       decode(PMRNL_MT_QO_S,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_QO_S) mtQoS_8026,
       decode(PMRNL_MT_RRC,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_RRC) mtRRC_8008,
       decode(PMRNL_MT_RAD_BEARER,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_RAD_BEARER) mtRadBearer_8007,
       decode(PMRNL_MT_S_1_AP,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_S_1_AP) mtS1AP_8000,
       decode(PMRNL_MS1SS_34,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MS1SS_34) mtS1SctpStatistics_8035,
       decode(PMRNL_MT_SINR,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_SINR) mtSINR_8031,
       decode(PMRNL_MT_TRANSP_LOAD,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_TRANSP_LOAD) mtTranspLoad_8004,
       decode(PMRNL_MUENSD_18,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MUENSD_18) mtUEandServiceDiff_8023,
       decode(PMRNL_MT_U_ESTATE,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_U_ESTATE) mtUEstate_8013,
       decode(PMRNL_MT_X_2_AP,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MT_X_2_AP) mtX2AP_8022,
       decode(PMRNL_MX2SS_35,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MX2SS_35) mtX2SctpStatistics_8036,
       decode(PMRNL_MTE_N_BLOAD,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MTE_N_BLOAD) mteNBload_8018,
       decode(PMRNL_MLHN_22,0,'disable',1,'15',2,'30',3,'60',4,'360',5,'720',6,'1440',PMRNL_MLHN_22) mtintraLTEHoNb_8015
 from  ctp_common_objects BTS,   
       ctp_common_objects PMBTS,      
       nasda_objects nao,
       nasda_objects emo,
       nd_in_em em,
       C_LTE_PMRNL PM
  where --(BTS.CO_OC_ID=4308 or BTS.CO_OC_ID=2860) --(lnbts.co_oc_id=2860 or lnbts.co_oc_id=4308)
        --and 
        nao.co_gid=bts.co_gid 
        and em.obj_gid=emo.co_gid 
        and emo.co_parent_gid=nao.co_gid 
        --and (PMBTS.CO_OC_ID=2874 or PMBTS.CO_OC_ID=4381)
        and PMBTS.CO_PARENT_GID=bts.CO_GID
        and PM.OBJ_GID=PMBTS.CO_GID
        and PM.CONF_ID =1
       --and BTS.CO_OBJECT_INSTANCE in ('659962')
 
order by 1,2
) pm
on
pm.enb_id_pm = kpi.enb_id
where
切换成功率QQ < 98.8
and 切换失败次数QQ > 500
and 
(mtIntereNBHo_8014 != 'disable'
or mtIntraeNBHo_8009 != 'disable')

--&1&2&3&4&5&6&7&8
