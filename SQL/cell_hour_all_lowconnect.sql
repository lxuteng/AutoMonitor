select kpi.*,pm.mtEPSBearer_8006,erl."QCI1话务量Erl_亿阳" from 

(

SELECT
substr(sdate,1,8) sdate
,
city
,enb_cell,enb_id,bts_version,cel_name
,Round(Decode(sum(M8006C188+M8006C197),0,100,100*sum(M8006C206+M8006C215)/sum(M8006C188+M8006C197)),2)*Round(Decode(sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21),0,0,100*sum(M8013C5)/sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21+M8013C31+ M8013C34)),2)/100 qci1无线接通率
,Round(Decode(sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21),0,0,100*sum(M8013C5)/sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21+M8013C31+ M8013C34)),2)  RRC连接建立成功率  --0409修改增加了+M8013C31+ M8013C34
,sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21+M8013C31+ M8013C34)-sum(M8013C5) RRC连接建立失败次数
,sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21+M8013C31+ M8013C34) RRC连接建立请求次数
,sum(拥塞次数) 拥塞次数
,Round(Decode(sum(M8006C188+M8006C197),0,100,100*sum(M8006C206+M8006C215)/sum(M8006C188+M8006C197)),2) qci1_erab建立成功率
,sum(M8006C188+M8006C197) qci1_erab建立请求次数
,sum(M8006C206+M8006C215) qci1_erab建立成功次数
,sum(M8006C188+M8006C197)-sum(M8006C206+M8006C215) qci1_erab建立失败次数
,Round(Decode((sum(M8005C54)+sum(M8005C55)+sum(M8005C56)+sum(M8005C57)+sum(M8005C58)+sum(M8005C59)+sum(M8005C60)+sum(M8005C61)+sum(M8005C62)+sum(M8005C63)+sum(M8005C64)+sum(M8005C65)+sum(M8005C66)+sum(M8005C67)+sum(M8005C68)+sum(M8005C69)+sum(M8005C70)+sum(M8005C71)+sum(M8005C72)+sum(M8005C73)+sum(M8005C74)+sum(M8005C75)+sum(M8005C76)+sum(M8005C77)+sum(M8005C78)+sum(M8005C79)+sum(M8005C80)+sum(M8005C81)+sum(M8005C82)+sum(M8005C83)+sum(M8005C84)+sum(M8005C85)),0,0,100*(sum(M8005C54)+sum(M8005C55)+sum(M8005C56)+sum(M8005C57)+sum(M8005C58)+sum(M8005C59)+sum(M8005C60)+sum(M8005C61)+sum(M8005C62)+sum(M8005C63)+sum(M8005C64)+sum(M8005C65))/(sum(M8005C54)+sum(M8005C55)+sum(M8005C56)+sum(M8005C57)+sum(M8005C58)+sum(M8005C59)+sum(M8005C60)+sum(M8005C61)+sum(M8005C62)+sum(M8005C63)+sum(M8005C64)+sum(M8005C65)+sum(M8005C66)+sum(M8005C67)+sum(M8005C68)+sum(M8005C69)+sum(M8005C70)+sum(M8005C71)+sum(M8005C72)+sum(M8005C73)+sum(M8005C74)+sum(M8005C75)+sum(M8005C76)+sum(M8005C77)+sum(M8005C78)+sum(M8005C79)+sum(M8005C80)+sum(M8005C81)+sum(M8005C82)+sum(M8005C83)+sum(M8005C84)+sum(M8005C85))),2) PHR小于0比例
,Round((avg(M8005C5)-avg(M8005C95)),2) PUSCH_RIP
,round(sum(M8006C181)/3600,2) QCI1话务量Erl  --2017年7月28日修改
,round(sum(M8006C45)/3600,2) "QCI1话务量Erl_all"
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
,M8005C5,M8005C54,M8005C55,M8005C56,M8005C57,M8005C58,M8005C59,M8005C60,M8005C61,M8005C62,M8005C63,M8005C64,M8005C65,M8005C66,M8005C67,M8005C68,M8005C69,M8005C70,M8005C71,M8005C72,M8005C73,M8005C74,M8005C75,M8005C76,M8005C77,M8005C78,M8005C79,M8005C80,M8005C81,M8005C82,M8005C83,M8005C84,M8005C85,M8005C87,M8005C88,M8005C89,M8005C95,M8006C0,M8006C1,M8006C125,M8006C13,M8006C14,M8006C143,M8006C168,M8006C169,M8006C170,M8006C176,M8006C177,M8006C178,M8006C179,M8006C180,M8006C181,M8006C188,M8006C189,M8006C197,M8006C198,M8006C206,M8006C207,M8006C215,M8006C216,M8006C224,M8006C225,M8006C244,M8006C245,M8006C248,M8006C249,M8006C252,M8006C253,M8006C257,M8006C269,M8006C273,M8006C287,M8006C291,M8006C3,M8006C35,M8006C36,M8006C4,M8006C45,M8006C46,M8006C5,M8006C54,M8013C16,M8013C17,M8013C18,M8013C19,M8013C20,M8013C21,M8013C31,M8013C34,M8013C47,M8013C5,M8013C59,M8013C60,M8013C65,M8013C66,M8013C67,M8013C68,M8013C69,M8013C8
      
,case when (bts_version='LNT5.0' or bts_version = 'LNZ5.0') then M8013C8 

else M8013C65+M8013C66+M8013C67+M8013C68+M8013C69 end 拥塞次数 --ERAB掉线率分母 自适应RL55/15A 

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

         period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
         
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8005
,


(
      select
             to_char(period_start_time,'yyyymmddHH24MI') sdatetime
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,sum(nvl(EPS_BEARER_SETUP_ATTEMPTS,0)) M8006C0 --The number of EPS bearer setup attempts. Each bearer of the "E-RAB to Be Setup List" IE is counted.
,sum(nvl(EPS_BEARER_SETUP_COMPLETIONS,0)) M8006C1 --The number of EPS bearer setup completions. Each bearer of the "E-RAB Setup List" IE is counted.
,sum(nvl(ENB_EPS_BEAR_REL_REQ_N_QCI1,0)) M8006C125 ----
,sum(nvl(ENB_EPS_BEARER_REL_REQ_OTH,0)) M8006C13 ----
,sum(nvl(ENB_EPS_BEARER_REL_REQ_TNL,0)) M8006C14 --This measurement provides the number of E-RABs released due to a failed Handover Completion phase at the target cell.
,sum(nvl(ENB_EPS_BEAR_REL_REQ_O_QCI1,0)) M8006C143 ----
,sum(nvl(EPS_BEARER_STP_COM_INI_QCI_2,0)) M8006C168 ----
,sum(nvl(EPS_BEARER_STP_COM_INI_QCI_3,0)) M8006C169 ----
,sum(nvl(EPS_BEARER_STP_COM_INI_QCI_4,0)) M8006C170 ----
,sum(nvl(ERAB_REL_ENB_ACT_QCI1,0)) M8006C176 --This measurement provides the number of released active E-RABs (that is when there was user data in the queue at the time of release) with QCI1 characteristics. The release is initiated by the eNB due to radio connectivity problems.
,sum(nvl(ERAB_REL_ENB_ACT_QCI2,0)) M8006C177 --This measurement provides the number of released active E-RABs (that is when there was user data in the queue at the time of release) with QCI2 characteristics. The release is initiated by the eNB due to radio connectivity problems.
,sum(nvl(ERAB_REL_ENB_ACT_QCI3,0)) M8006C178 --This measurement provides the number of released active E-RABs (that is when there was user data in the queue at the time of release) with QCI3 characteristics. The release is initiated by the eNB due to radio connectivity problems.
,sum(nvl(ERAB_REL_ENB_ACT_QCI4,0)) M8006C179 --This measurement provides the number of released active E-RABs (that is when there was user data in the queue at the time of release) with QCI4 characteristics. The release is initiated by the eNB due to radio connectivity problems.
,sum(nvl(ERAB_REL_ENB_ACT_NON_GBR,0)) M8006C180 --This measurement provides the number of released active E-RABs (that is when there was user data in the queue at the time of release) with non-GBR characteristics (QCI5...9). The release is initiated by the eNB due to radio connectivity problems.
,sum(nvl(ERAB_INI_SETUP_ATT_QCI1,0)) M8006C188 --This measurement provides the number of setup attempts for initial E-RABs of QCI1.
,sum(nvl(ERAB_INI_SETUP_ATT_QCI2,0)) M8006C189 --This measurement provides the number of setup attempts for initial E-RABs of QCI2.
,sum(nvl(ERAB_ADD_SETUP_ATT_QCI1,0)) M8006C197 --This measurement provides the number of setup attempts for additional E-RABs of QCI1.
,sum(nvl(ERAB_ADD_SETUP_ATT_QCI2,0)) M8006C198 --This measurement provides the number of setup attempts for additional E-RABs of QCI2.
,sum(nvl(ERAB_INI_SETUP_SUCC_QCI1,0)) M8006C206 --This measurement provides the number of successfully established initial E-RABs of QCI1.
,sum(nvl(ERAB_INI_SETUP_SUCC_QCI2,0)) M8006C207 --This measurement provides the number of successfully established initial E-RABs of QCI2.
,sum(nvl(ERAB_ADD_SETUP_SUCC_QCI1,0)) M8006C215 --This measurement provides the number of successfully established additional E-RABs of QCI1.
,sum(nvl(ERAB_ADD_SETUP_SUCC_QCI2,0)) M8006C216 --This measurement provides the number of successfully established additional E-RABs of QCI2.
,max(SIMUL_ERAB_QCI1_MAX) M8006C224 --This measurement provides the maximum of sampled values for measuring the number of simultaneously established E-RABs with QCI1 characteristics.
,max(SIMUL_ERAB_QCI2_MAX) M8006C225 --This measurement provides the maximum of sampled values for measuring the number of simultaneously established E-RABs with QCI2 characteristics.
,sum(nvl(ERAB_REL_ENB_TNL_TRU,0)) M8006C257 --This measurement provides the number of E-RABs released if the associated transport resources are not available anymore. The counter is maintained regardless of the released bearers QCI.
,sum(nvl(EPS_BEARER_SETUP_FAIL_TRPORT,0)) M8006C3 ----
,sum(nvl(EPS_BEARER_STP_COM_INI_QCI1,0)) M8006C35 ----
,sum(nvl(EPS_BEAR_STP_COM_INI_NON_GBR,0)) M8006C36 ----
,sum(nvl(EPS_BEARER_SETUP_FAIL_RESOUR,0)) M8006C4 ----
,sum(nvl(SUM_SIMUL_ERAB_QCI_1,0)) M8006C45 --This measurement provides the sum of sampled values for measuring the number of simultaneous E-RABs with QCI 1 characteristics. This counter, divided by the denominator DENOM_SUM_SIMUL_ERAB, provides the average number of simultaneous QCI 1 E-RABs per cell.
,sum(nvl(SUM_SIMUL_ERAB_QCI_2,0)) M8006C46 --This measurement provides the sum of sampled values for measuring the number of simultaneous E-RABs with QCI 2 characteristics. This counter, divided by the denominator DENOM_SUM_SIMUL_ERAB, provides the average number of simultaneous QCI 2 E-RABs per cell.
,sum(nvl(EPS_BEARER_SETUP_FAIL_OTH,0)) M8006C5 ----
,sum(nvl(DENOM_SUM_SIMUL_ERAB,0)) M8006C54 --This measurement provides the number of samples, which were taken to determine the number of simultaneous E-RABs per QCI.
,sum(nvl(ERAB_REL_ENB_TNL_TRU_QCI1,0)) M8006C269 
,sum(nvl(ERAB_REL_HO_PART_QCI1,0)) M8006C273
,sum(nvl(ERAB_IN_SESSION_TIME_QCI1,0)) M8006C181

,sum(nvl(ERAB_INI_SETUP_FAIL_RNL_RRNA,0)) M8006C244
,sum(nvl(ERAB_INI_SETUP_FAIL_TNL_TRU,0)) M8006C245
,sum(nvl(ERAB_ADD_SETUP_FAIL_RNL_RRNA,0)) M8006C248
,sum(nvl(ERAB_ADD_SETUP_FAIL_TNL_TRU,0)) M8006C249
,sum(nvl(ERAB_ADD_SETUP_FAIL_UP,0)) M8006C252
,sum(nvl(ERAB_ADD_SETUP_FAIL_RNL_MOB,0)) M8006C253
,sum(nvl(ERAB_REL_ENB_TNL_TRU_QCI2,0)) M8006C287
,sum(nvl(ERAB_REL_HO_PART_QCI2,0)) M8006C291

        from
             NOKLTE_PS_LEPSB_MNC1_raw PMRAW
        where
        
         period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
            ---- to_char(period_start_time,'yyyymmddHH24MI') >= to_char(SYSDATE-1,'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8006
,
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
Select lnbts_id,lncel_id,period_start_time from NOKLTE_PS_LRDB_MNC1_raw m8007
Union
Select lnbts_id,lncel_id,period_start_time from NOKLTE_PS_LCELAV_MNC1_raw m8020
)
) comm,
ctp_common_objects lnbts,
ctp_common_objects lncel
where 
comm.period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')

and comm.lnbts_id=lnbts.co_gid
AND comm.LNCEL_ID=lncel.co_gid
AND lnbts.CO_STATE<>9 
AND lncel.CO_STATE<>9
             
             
)comm,(
select
             to_char(period_start_time,'yyyymmddHH24MI') sdate
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,sum(nvl(ENB_INIT_TO_IDLE_OTHER,0)) M8013C16 --The number of eNB-initiated transitions from the ECM-CONNECTED to ECM-IDLE state for all TNL causes indicating an abnormal release. The UE-associated logical S1-connection is released.
,sum(nvl(SIGN_CONN_ESTAB_ATT_MO_S,0)) M8013C17 --The number of Signaling Connection Establishment attempts for mobile originated signaling. From UE's point of view, the transition from ECM-IDLE to ECM-CONNECTED has started.
,sum(nvl(SIGN_CONN_ESTAB_ATT_MT,0)) M8013C18 --The number of Signaling Connection Establishment attempts for mobile terminated connections. From UE's point of view, the transition from ECM-IDLE to ECM-CONNECTED is started.
,sum(nvl(SIGN_CONN_ESTAB_ATT_MO_D,0)) M8013C19 --The number of Signaling Connection Establishment attempts for mobile originated data connections. From UE's point of view, the transition from ECM-IDLE to ECM-CONNECTED is started.
,sum(nvl(SIGN_CONN_ESTAB_ATT_OTHERS,0)) M8013C20 ----
,sum(nvl(SIGN_CONN_ESTAB_ATT_EMG,0)) M8013C21 --Number of Signaling Connection Establishment attempts for emergency calls.
,sum(nvl(SIGN_CONN_ESTAB_ATT_HIPRIO,0)) M8013C31 --The number of Signaling Connection Establishment attempts for highPriorityAccess connections. From UE's point of view, the transition from ECM-IDLE to ECM-CONNECTED is started.
,sum(nvl(SIGN_CONN_ESTAB_ATT_DEL_TOL,0)) M8013C34 --The number of Signaling Connection Establishment attempts for delayTolerantAccess connections. From UE's point of view, the transition from ECM-IDLE to ECM-CONNECTED is started."
,sum(nvl(UE_CTX_SETUP_SUCC,0)) M8013C47 --This measurement provides the number of successfully established UE Contexts. It includes also the UE Contexts that are subject to CS Fallback.
,sum(nvl(SIGN_CONN_ESTAB_COMP,0)) M8013C5 --This measurement provides the number of successful RRC Connection Setups.
,sum(nvl(UE_CTX_REL_ENB_NO_RADIO_RES,0)) M8013C59 --This counter provides the number of released UE contexts initiated by the eNB due to missing radio resources.
,sum(nvl(UE_CTX_REL_ENB_RNL_UNSPEC,0)) M8013C60 --This counter provides the number of released UE contexts initiated by the eNB with the release cause "RNL Unspecified". It is used e.g. in case of AS Security problems or in case of abnormal handover conditions.
,sum(nvl(SIGN_CONN_ESTAB_FAIL_OVLCP,0)) M8013C65 --This measurement provides the total number of Signaling Connection Establishment Requests rejected due to Control Plane overload.
,sum(nvl(SIGN_CONN_ESTAB_FAIL_OVLUP,0)) M8013C66 --This measurement provides the total number of Signaling Connection Establishment Requests rejected due to User Plane overload.
,sum(nvl(SIGN_CONN_ESTAB_FAIL_PUCCH,0)) M8013C67 --This measurement provides the total number of Signaling Connection Establishment Requests rejected due to lack of PUCCH resources.
,sum(nvl(SIGN_CONN_ESTAB_FAIL_MAXRRC,0)) M8013C68 --This measurement provides the total number of Signaling Connection Establishment Requests rejected in case that the maximum number of RRC Connected UEs is reached.
,sum(nvl(SIGN_CONN_ESTAB_FAIL_OVLMME,0)) M8013C69 --This measurement provides the total number of Signaling Connection Establishment Requests rejected due to overload indicated by the MME.
,sum(nvl(SIGN_CONN_ESTAB_FAIL_RRMRAC,0)) M8013C8 ----


----,lnbts.co_object_instance enb_id
----,lncel.co_object_instance cell_id
--,lnbts.co_main_host bts_ip
----,lnbts.co_sys_version bts_version
----,Trim(lnbts.co_name) bts_name
----,Trim(lncel.co_name) cel_name
        from
             NOKLTE_PS_LUEST_MNC1_raw PMRAW--,ctp_common_objects lnbts,ctp_common_objects lncel
        where
             period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
             
           ---  to_char(period_start_time,'yyyymmddHH24MI') >= to_char(SYSDATE-1,'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             ----AND PMRAW.LNCEL_ID=lncel.co_gid AND lnbts.co_oc_id=2860 AND lnbts.CO_STATE<>9 AND lncel.co_oc_id=2881 AND lncel.CO_STATE<>9
            ----and PMRAW.lnbts_id=lnbts.co_gid
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),MRBTS_ID,LNBTS_ID,LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
             ----,lnbts.co_object_instance,lncel.co_object_instance--,lnbts.co_main_host
             ----,lnbts.co_sys_version,Trim(lnbts.co_name),Trim(lncel.co_name)
)M8013
WHERE      
comm.cel_key_id=m8005.cel_key_id(+)
       AND comm.cel_key_id=m8006.cel_key_id(+)
       AND comm.cel_key_id=m8013.cel_key_id(+)

)
WHERE  enb_id between '0' and '999999'  
--and enb_id in ('701771','823557','701812','823136','701567','823546','837915','716822','340771','838344','684246','838361','201852','823229','340995','838040','837999','340772','823580','716878','201888','838189','838146','823776','823788','837916','823579','823787','201743','838147','838233','340805','823283','340773','823654','684172','341014','838345','823448','823506','340870','838237','823467','838037','838016','838393','823382','716811','823280','823057','823447','837986','341010','823707','823309','201933','823128','201930','701341','701340','838362','701334','659922','201887','716996','701306','823432','659950','659972','701640','701407','701810','701332','701576','659902','659982','701692','701521','823431','701187','716989','660220','659954','659937','659953','659932','701811','716949','659933','701488','701436','701349','701284','701793','659961','659967','701333','659910','701773','701419','701600','701346','659963','716862','659987','659962','701480','701474','341021','717025','701417')
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
substr(sdate,1,8),
city,enb_cell,enb_id,bts_version,cel_name
ORDER BY substr(sdate,1,8)--,enb_cell,enb_id

) kpi,
(
select BTS.CO_OBJECT_INSTANCE enb_id,
       BTS.CO_NAME bts_name,
       BTS.CO_SYS_VERSION  BTS_VERSION,
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
,
(SELECT
substr(sdate,1,8) sdate
,enb_cell
,enb_id
,round(sum(M8006C45)/3600,2) "QCI1话务量Erl_all"
,round(sum(话务量hour),2) "QCI1话务量Erl_亿阳"
FROM

(
SELECT 
substr(comm.sdate,1,10) sdate
,enb_cell
,enb_id
,sum(M8006C45) M8006C45
--,M8006C54
,avg(话务量raw) 话务量hour

 
FROM

(
      select
             to_char(period_start_time,'yyyymmddHH24MI') sdatetime
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id

,sum(nvl(SUM_SIMUL_ERAB_QCI_1,0)) M8006C45 --This measurement provides the sum of sampled values for measuring the number of simultaneous E-RABs with QCI 1 characteristics. This counter, divided by the denominator DENOM_SUM_SIMUL_ERAB, provides the average number of simultaneous QCI 1 E-RABs per cell.
,sum(nvl(DENOM_SUM_SIMUL_ERAB,0)) M8006C54 --This measurement provides the number of samples, which were taken to determine the number of simultaneous E-RABs per QCI.
,decode(sum(nvl(DENOM_SUM_SIMUL_ERAB,0)),0,0,sum(nvl(SUM_SIMUL_ERAB_QCI_1,0))/sum(nvl(DENOM_SUM_SIMUL_ERAB,0))) 话务量raw
        from
             NOKLTE_PS_LEPSB_MNC1_raw PMRAW
        where
        
         period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
            ---- to_char(period_start_time,'yyyymmddHH24MI') >= to_char(SYSDATE-1,'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8006
,
(
select
to_char(period_start_time,'yyyymmddHH24MI') sdate
,LNCEL_ID
,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,lnbts.co_object_instance enb_id
,lncel.co_object_instance cell_id
,lnbts.co_object_instance || '_' || lncel.co_object_instance enb_cell 
--,lnbts.co_main_host bts_ip
,lnbts.co_sys_version bts_version
,Trim(lnbts.co_name) bts_name
,Trim(lncel.co_name) cel_name  
from
(
Select Distinct * from 
(
Select lnbts_id,lncel_id,period_start_time from NOKLTE_PS_LRDB_MNC1_raw m8007
Union
Select lnbts_id,lncel_id,period_start_time from NOKLTE_PS_LCELAV_MNC1_raw m8020
)
) comm,
ctp_common_objects lnbts,
ctp_common_objects lncel
where 
comm.period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
and comm.lnbts_id=lnbts.co_gid
AND comm.LNCEL_ID=lncel.co_gid
AND lnbts.CO_STATE<>9 
AND lncel.CO_STATE<>9
              
)comm
WHERE      comm.cel_key_id=m8006.cel_key_id(+)
group by 
substr(comm.sdate,1,10),enb_id,enb_cell
)







WHERE 
enb_id between '0' and '999999'  
--enb_id in ('701317')
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
substr(sdate,1,8)
,enb_cell
,enb_id
ORDER BY substr(sdate,1,8),enb_cell,enb_id
) erl

where 
kpi.enb_id = pm.enb_id
and
kpi.enb_cell = erl.enb_cell

and erl."QCI1话务量Erl_亿阳" > 1
--and erl."QCI1话务量Erl_亿阳" < 1
and kpi.qci1无线接通率 < 95
--and pm.mtEPSBearer_8006 != 'disable'
--order by kpi."QCI1话务量Erl_亿阳"


--&1&2&3&4&5&6&7&8&9
