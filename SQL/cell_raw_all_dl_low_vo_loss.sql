select kpi.*,pm.mtQoS_8026,erl."QCI1话务量Erl_亿阳" from 

(

SELECT
substr(sdate,1,8) sdate
,
city
,enb_cell,enb_id,bts_version,cel_name
,round(decode(sum(M8001C305),0,0,sum(M8026C255)/sum(M8001C305)*100),2) QCI1上行丢包率
,round(decode(sum(M8001C314+M8026C260),0,0,sum(M8026C260)/sum(M8001C314+M8026C260)*100),2) QCI1下行丢包率
,Round(Decode((sum(M8005C54)+sum(M8005C55)+sum(M8005C56)+sum(M8005C57)+sum(M8005C58)+sum(M8005C59)+sum(M8005C60)+sum(M8005C61)+sum(M8005C62)+sum(M8005C63)+sum(M8005C64)+sum(M8005C65)+sum(M8005C66)+sum(M8005C67)+sum(M8005C68)+sum(M8005C69)+sum(M8005C70)+sum(M8005C71)+sum(M8005C72)+sum(M8005C73)+sum(M8005C74)+sum(M8005C75)+sum(M8005C76)+sum(M8005C77)+sum(M8005C78)+sum(M8005C79)+sum(M8005C80)+sum(M8005C81)+sum(M8005C82)+sum(M8005C83)+sum(M8005C84)+sum(M8005C85)),0,0,100*(sum(M8005C54)+sum(M8005C55)+sum(M8005C56)+sum(M8005C57)+sum(M8005C58)+sum(M8005C59)+sum(M8005C60)+sum(M8005C61)+sum(M8005C62)+sum(M8005C63)+sum(M8005C64)+sum(M8005C65))/(sum(M8005C54)+sum(M8005C55)+sum(M8005C56)+sum(M8005C57)+sum(M8005C58)+sum(M8005C59)+sum(M8005C60)+sum(M8005C61)+sum(M8005C62)+sum(M8005C63)+sum(M8005C64)+sum(M8005C65)+sum(M8005C66)+sum(M8005C67)+sum(M8005C68)+sum(M8005C69)+sum(M8005C70)+sum(M8005C71)+sum(M8005C72)+sum(M8005C73)+sum(M8005C74)+sum(M8005C75)+sum(M8005C76)+sum(M8005C77)+sum(M8005C78)+sum(M8005C79)+sum(M8005C80)+sum(M8005C81)+sum(M8005C82)+sum(M8005C83)+sum(M8005C84)+sum(M8005C85))),2) PHR小于0比例
,Round((avg(M8005C5)-avg(M8005C95)),2) PUSCH_RIP
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
,M8001C147,M8001C148,M8001C150,M8001C151,M8001C153,M8001C154,M8001C200,M8001C216,M8001C217,M8001C223,M8001C224,M8001C269,m8001c286,M8001C305,M8001C306,M8001C314,M8001C315,M8001C320,M8001C321,M8001C323,M8001C324,M8001C494,M8001C495,M8001C496,m8001c6,m8001c7,M8001C8,M8005C5,M8005C54,M8005C55,M8005C56,M8005C57,M8005C58,M8005C59,M8005C60,M8005C61,M8005C62,M8005C63,M8005C64,M8005C65,M8005C66,M8005C67,M8005C68,M8005C69,M8005C70,M8005C71,M8005C72,M8005C73,M8005C74,M8005C75,M8005C76,M8005C77,M8005C78,M8005C79,M8005C80,M8005C81,M8005C82,M8005C83,M8005C84,M8005C85,M8005C87,M8005C88,M8005C89,M8005C95,M8006C0,M8006C1,M8006C125,M8006C13,M8006C14,M8006C143,M8006C168,M8006C169,M8006C170,M8006C176,M8006C177,M8006C178,M8006C179,M8006C180,M8006C181,M8006C188,M8006C189,M8006C197,M8006C198,M8006C206,M8006C207,M8006C215,M8006C216,M8006C224,M8006C225,M8006C244,M8006C245,M8006C248,M8006C249,M8006C252,M8006C253,M8006C257,M8006C269,M8006C273,M8006C287,M8006C291,M8006C3,M8006C35,M8006C36,M8006C4,M8006C45,M8006C46,M8006C5,M8006C54,M8026C254,M8026C255,M8026C256,M8026C259,M8026C260,M8026C261,M8026C30

 
FROM
( select
             to_char(period_start_time,'yyyymmddHH24MI') sdate
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,avg(nvl(DL_UE_DATA_BUFF_AVG,0)) M8001C147 --The average number of UE contexts per TTI with UP data on the RLC-level buffers in the DL (active users). This measurement can be used to monitor the congestion level of the eNB queuing system, which is realized by schedulers for the shared channels.The reported value is 100 times higher than the actual value (for example, 1.00 is stored as 100)."
,max(nvl(DL_UE_DATA_BUFF_MAX,0)) M8001C148 --The maximum number of UE contexts per TTI with UP data on the RLC-level buffers in the DL (active users). This measurement can be used to monitor the congestion level of the eNB queuing system, which is realized by schedulers for the shared channels.
,avg(nvl(UL_UE_DATA_BUFF_AVG,0)) M8001C150 --The average number of UE contexts per TTI having buffered DRB data in the UL (active users). This measurement can be used to monitor the congestion level of the eNB queuing system, which is realized by schedulers for the shared channels.The reported value is 100 times higher than the actual value (for example, 1.00 is stored as 100)."
,max(nvl(UL_UE_DATA_BUFF_MAX,0)) M8001C151 --The maximum number of UE contexts per TTI having buffered DRB data in the UL (active users). This measurement can be used to monitor the congestion level of the eNB queuing system, which is realized by schedulers for the shared channels (Inter-RAT Redirection).
,max(nvl(RRC_CONN_UE_MAX,0)) M8001C200 --The highest value for number of UEs in RRC_CONNECTED state over the measurement period.
,avg(nvl(MEAN_PRB_AVAIL_PDSCH,0)) M8001C216 --This measurement provides the average number of PRBs on PDSCH available for dynamic scheduling.
,avg(nvl(MEAN_PRB_AVAIL_PUSCH,0)) M8001C217 --This measurement provides the average number of PRBs on PUSCH available for dynamic scheduling.
,avg(nvl(CELL_LOAD_ACT_UE_AVG,0)) M8001C223 --The average number of active UEs per cell during measurement period. A UE is active if at least a single non-GBR DRB has been successfully configured for it.
,max(nvl(CELL_LOAD_ACT_UE_MAX,0)) M8001C224 --The maximum number of active UEs per cell during measurement period. A UE is active if at least a single non-GBR DRB has been successfully configured for it.
,avg(nvl(PDCP_RET_DL_DEL_MEAN_QCI_1,0)) M8001C269 --The mean retention delay for a PDCP SDU (DL) inside eNB per QCI 1
,sum(nvl(RACH_STP_ATT_DEDICATED,0)) m8001c286 --The number of RACH setup attempts for dedicated preambles.
,sum(nvl(PDCP_SDU_UL_QCI_1,0)) M8001C305 --This measurement provides the number of received PDCP SDUs for QCI 1 bearers.Only user-plane traffic (DTCH) is considered."
,sum(nvl(PDCP_SDU_UL_QCI_2,0)) M8001C306 --This measurement provides the number of received PDCP SDUs for QCI 2 bearers.Only user-plane traffic (DTCH) is considered."
,sum(nvl(PDCP_SDU_DL_QCI_1,0)) M8001C314 --The number of transmitted PDCP SDUs in downlink for QCI 1
,sum(nvl(PDCP_SDU_DL_QCI_2,0)) M8001C315 --This measurement provides the number of transmitted PDCP SDUs in downlink for GBR DRBs of QCI2 characteristics.
,sum(nvl(SUM_ACTIVE_UE,0)) M8001C320 --This measurement provides the sum of sampled values for measuring the number of simultaneously Active UEs. This counter divided by the denominator DENOM_ACTIVE_UE provides the average number of Active UEs per cell.A UE is active if at least a single non-GBR DRB has been successfully configured for it."
,sum(nvl(DENOM_ACTIVE_UE,0)) M8001C321 --The number of samples taken for counter SUM_ACTIVE_UE used as a denominator for average calculation.
,sum(nvl(PDCP_SDU_DISC_DL_QCI_1,0)) M8001C323 --This measurement provides the number of discarded PDCP SDUs in downlink for GBR DRBs of QCI1 bearers.
,sum(nvl(PDCP_SDU_DISC_DL_QCI_2,0)) M8001C324 --This measurement provides the number of discarded PDCP SDUs in downlink for GBR DRBs of QCI2 characteristics.
,sum(nvl(RACH_STP_ATT_SMALL_MSG,0)) m8001c6 --The number of RACH setup attempts for small size messages (only contention based).
,sum(nvl(RACH_STP_ATT_LARGE_MSG,0)) m8001c7 --The number of RACH setup attempts for large size messages (only contention based).
,sum(nvl(RACH_STP_COMPLETIONS,0)) M8001C8 --The number of RACH setup completions (contention based and dedicated preambles).
,sum(nvl(PDCP_SDU_UL,0)) M8001C153
,sum(nvl(PDCP_SDU_DL,0)) M8001C154
,avg(nvl(CA_DL_CAP_UE_AVG,0)) M8001C494
,avg(nvl(CA_SCELL_CONF_UE_AVG,0)) M8001C495
,avg(nvl(CA_SCELL_ACTIVE_UE_AVG,0)) M8001C496
,case when max(nvl(CELL_LOAD_ACT_UE_MAX,0)) >= 300 and max(nvl(CELL_LOAD_ACT_UE_MAX,0)) is not null then 1 else 0 end 是否超300用户M8001

FROM NOKLTE_PS_LCELLD_MNC1_raw PMRAW
        where
             ---to_char(period_start_time,'yyyymmddHH24MI') >= to_char(SYSDATE-1,'yyyymmddHH24MI')
         period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8001
,



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
             to_char(period_start_time,'yyyymmddHH24MI') sdatetime
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
            ,sum(nvl(IP_TPUT_VOL_DL_QCI_1,0)) M8012C117 --This measurement provides IP throughput volume on QCI 1 bearers in downlink as experienced by the UE.
,sum(nvl(IP_TPUT_TIME_DL_QCI_1,0)) M8012C118 --This measurement provides IP throughput time on QCI 1 bearers in downlink.
,sum(nvl(IP_TPUT_VOL_DL_QCI_2,0)) M8012C119 --This measurement provides IP throughput volume on QCI 2 bearers in downlink as experienced by the UE.
,sum(nvl(PDCP_SDU_VOL_UL,0)) M8012C19 --The measurement gives an indication of the eUu interface traffic load by reporting the total received PDCP SDU-related traffic volume.
,sum(nvl(PDCP_SDU_VOL_DL,0)) M8012C20 --The measurement gives an indication of the eUu interface traffic load by reporting the total transmitted PDCP SDU-related traffic volume.
,sum(nvl(IP_TPUT_VOL_UL_QCI_1,0)) M8012C91 --This measurement provides IP throughput volume on QCI 1 bearers in uplink as experienced by the UE.
,sum(nvl(IP_TPUT_TIME_UL_QCI_1,0)) M8012C92 --This measurement provides IP throughput time on QCI 1 bearers in uplink.
,sum(nvl(IP_TPUT_VOL_UL_QCI_2,0)) M8012C93 --This measurement provides IP throughput volume on QCI 2 bearers in uplink as experienced by the UE.
,sum(nvl(RLC_PDU_DL_VOL_CA_SCELL,0)) M8012C151
,max(nvl(PDCP_DATA_RATE_MAX_UL,0)) M8012C22
,max(nvl(PDCP_DATA_RATE_MAX_DL,0)) M8012C25
,sum(nvl(ACTIVE_TTI_UL,0)) M8012C89
,sum(nvl(ACTIVE_TTI_DL,0)) M8012C90

        from
             NOKLTE_PS_LCELLT_MNC1_raw PMRAW
        where
        
         period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
            ---- to_char(period_start_time,'yyyymmddHH24MI') >= to_char(SYSDATE-1,'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
) M8012,
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
,(
select
             to_char(period_start_time,'yyyymmddHH24MI') sdatetime
            -- ,MRBTS_ID
             ,LNBTS_ID
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,sum(nvl(PDCP_SDU_LOSS_UL_QCI_1_FNA,0)) M8026C255 --Number of missing UL PDCP packets of a data bearer with QCI = 1 that are not delivered to higher layers. Missing packets are identified by the missing PDCP sequence number.Only user-plane traffic (DTCH) is considered."
,sum(nvl(PDCP_SDU_LOSS_UL_QCI_2_FNA,0)) M8026C256 --Number of missing UL PDCP packets of a data bearer with QCI = 2 that are not delivered to higher layers. Missing packets are identified by the missing PDCP sequence number.Only user-plane traffic (DTCH) is considered."
,sum(nvl(PDCP_SDU_LOSS_DL_QCI_1_FNA,0)) M8026C260 --Number of DL PDCP SDUs of a data radio bearer with QCI = 1 that could not be successfully transmitted.Only user-plane traffic (DTCH) is considered."
,sum(nvl(PDCP_SDU_LOSS_DL_QCI_2_FNA,0)) M8026C261 --Number of DL PDCP SDUs of a data radio bearer with QCI = 2 that could not be successfully transmitted. Only user-plane traffic (DTCH) is considered."
,avg(HARQ_DURATION_QCI1_AVG) M8026C30 --The counter provides the average time for HARQ transmissions of QCI 1 data during one measurement period.
,sum(nvl(PDCP_SDU_LOSS_UL_FNA,0)) M8026C254
,sum(nvl(PDCP_SDU_LOSS_DL_FNA,0)) M8026C259
        from
            NOKLTE_PS_LQOS_MNC1_raw  PMRAW  
        where
             period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),MRBTS_ID,LNBTS_ID,LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8026

WHERE      comm.cel_key_id=m8001.cel_key_id(+)
       AND comm.cel_key_id=m8005.cel_key_id(+)
       AND comm.cel_key_id=m8006.cel_key_id(+)
       AND comm.cel_key_id=m8012.cel_key_id(+)
       AND comm.cel_key_id=m8026.cel_key_id(+)

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

and erl."QCI1话务量Erl_亿阳" > 1.5
and (kpi.QCI1下行丢包率 > 1 or kpi.QCI1上行丢包率 > 1)
and pm.mtQoS_8026 != 'disable'
--order by kpi."QCI1话务量Erl_亿阳"


--&1&2&3&4&5&6&7&8&9
