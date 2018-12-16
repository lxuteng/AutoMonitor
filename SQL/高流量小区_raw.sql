select 
substr(sdate,1,8) sdate
,enb_id
,enb_cell
,bts_version
,cel_name
,mtCellThruput_8012
,sum(业务量GB) 业务量GB
,max(RRC最大连接数) RRC最大连接数
,max(有效RRC连接最大数) 有效RRC连接最大数
,max(上行PRB平均利用率new) 上行PRB平均利用率new
,max(下行PRB平均利用率new) 下行PRB平均利用率new
,max(PDCCH信道CCE占用率) PDCCH信道CCE占用率
from
(
SELECT
substr(sdate,1,12) sdate
,
city
,enb_cell,enb_id,bts_version,cel_name
,mtCellThruput_8012
,Round(sum(M8012C19+M8012C20)/(1000*1000*1000),2)   业务量GB
,Round(sum(M8012C19)/(1024),2)   用户面PDCP上行数据量KB
,Round(sum(M8012C20)/(1024),2)   用户面PDCP下行数据量KB
,max(最大激活用户数)  最大激活用户数       
,max(RRC最大连接数)  RRC最大连接数 
,case when max(上行有效RRC连接最大数)>max(下行有效RRC连接最大数) then max(上行有效RRC连接最大数) else max(下行有效RRC连接最大数) end 有效RRC连接最大数
,round(decode(sum(M8011C38),0,0,(sum(M8011C39)*1+sum(M8011C40)*2+sum(M8011C41)*4+sum(M8011C42)*8)/sum(M8011C38)*100),2) PDCCH信道CCE占用率
,case when length(TO_CHAR(SYSDATE,'YYYYMMDD'))=8 and length(TO_CHAR(SYSDATE+1,'YYYYMMDD'))=8 then round(decode(avg(M8001C217)+ avg(M8001C216),0,0,(avg(M8011C50)/(24*60*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)/(avg(M8001C217)+ avg(M8001C216)))*100,2) 
      when length(TO_CHAR(SYSDATE,'YYYYMMDD'))=10 and length(TO_CHAR(SYSDATE+1,'YYYYMMDD'))=10 then round(decode(avg(M8001C217)+ avg(M8001C216),0,0,(avg(M8011C50)/(60*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)/(avg(M8001C217)+ avg(M8001C216)))*100,2)
      when length(TO_CHAR(SYSDATE,'YYYYMMDD'))=12 and length(TO_CHAR(SYSDATE+1,'YYYYMMDD'))=12 then round(decode(avg(M8001C217)+ avg(M8001C216),0,0,(avg(M8011C50)/(15*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)/(avg(M8001C217)+ avg(M8001C216)))*100,2)
end 无线利用率  --2017年10月13日更新
,case when length(TO_CHAR(SYSDATE,'YYYYMMDD'))=8 and length(TO_CHAR(SYSDATE+1,'YYYYMMDD'))=8 then round(avg(M8011C50)/(24*60*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)
      when length(TO_CHAR(SYSDATE,'YYYYMMDD'))=10 and length(TO_CHAR(SYSDATE+1,'YYYYMMDD'))=10 then round(avg(M8011C50)/(60*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)
      when length(TO_CHAR(SYSDATE,'YYYYMMDD'))=12 and length(TO_CHAR(SYSDATE+1,'YYYYMMDD'))=12 then round(avg(M8011C50)/(15*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)
end 无线利用率分子  --2017年10月13日更新
,round(avg(M8001C217)+ avg(M8001C216),0) 无线利用率分母


--,decode(avg(M8001C217),0,0,round(100*avg(M8011C50avg)/(24*60*60*1000/5)/avg(M8001C217),2)) 上行PRB平均利用率new  --day
--,avg(M8011C50avg) 上行PRB平均利用率分子  --day
--,24*60*60*1000/5*avg(M8001C217) 上行PRB平均利用率分母  --day
--,decode(avg(M8001C217),0,0,round(100*avg(M8011C50avg)/(60*60*1000/5)/avg(M8001C217),2)) 上行PRB平均利用率new  --hour
--,avg(M8011C50avg) 上行PRB平均利用率分子  --hour
--,60*60*1000/5*avg(M8001C217) 上行PRB平均利用率分母  --hour
,decode(avg(M8001C217),0,0,round(100*avg(M8011C50avg)/(15*60*1000/5)/avg(M8001C217),2)) 上行PRB平均利用率new  --raw
,avg(M8011C50avg) 上行PRB平均利用率分子  --raw
,15*60*1000/5*avg(M8001C217) 上行PRB平均利用率分母  --raw


,round(avg(M8011C37)/10,2) 下行PRB平均利用率new 


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
,M8001C147,M8001C148,M8001C150,M8001C151,M8001C153,M8001C154,M8001C200,M8001C216,M8001C217,M8001C223,M8001C224,M8001C269,m8001c286,M8001C305,M8001C306,M8001C314,M8001C315,M8001C320,M8001C321,M8001C323,M8001C324,M8001C494,M8001C495,M8001C496,m8001c6,m8001c7,M8001C8,M8011C37,M8011C38,M8011C39,M8011C40,M8011C41,M8011C42,M8011C50,M8011C50avg,M8011C67,M8011C68,M8012C117,M8012C118,M8012C119,M8012C151,M8012C19,M8012C20,M8012C22,M8012C25,M8012C89,M8012C90,M8012C91,M8012C92,M8012C93,M8051C107,M8051C108,M8051C109,M8051C110,M8051C55,M8051C56,M8051C57,M8051C58,M8051C62,M8051C63
,mtCellThruput_8012
,case when bts_version = 'TL16A' or bts_version = 'TLF16A' then M8051C57
 else M8001C223 end 平均激活用户数 
,case when bts_version = 'TL16A' or bts_version = 'TLF16A' then M8051C58
 else M8001C224 end 最大激活用户数     
,case when bts_version = 'TL16A' or bts_version = 'TLF16A' then M8051C56
 else M8001C200 end   RRC最大连接数 
   
,case when (bts_version='TL16A' or bts_version = 'TLF16A') then M8051C107/100
      else M8001C147/100 end 下行有效RRC连接平均数 
,case when (bts_version='TL16A' or bts_version = 'TLF16A') then M8051C109/100
      else M8001C150/100 end 上行有效RRC连接平均数        
,case when (bts_version='TL16A' or bts_version = 'TLF16A') then M8051C108
      else M8001C148 end 下行有效RRC连接最大数
,case when (bts_version='TL16A' or bts_version = 'TLF16A') then M8051C110
      else M8001C151 end 上行有效RRC连接最大数  





		
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


(
select
             to_char(period_start_time,'yyyymmddHH24MI') sdate
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,avg(DL_PRB_UTIL_TTI_MEAN) M8011C37 --The mean value of the DL Physical Resource Block (PRB) use per TTI. The use is defined by the rate of used PRB per TTI. The reported value is 10 times higher than the actual value (for example 5.4 is stored as 54)."
,sum(nvl(CCE_AVAIL_ACT_TTI,0)) M8011C38 --Total number of CCEs available for active TTIs when at least one PDCCH is going to be scheduled.
,sum(nvl(AGG1_USED_PDCCH,0)) M8011C39 --Total number of AGG1 used for PDCCH scheduling over the measurement period.
,sum(nvl(AGG2_USED_PDCCH,0)) M8011C40 --Total number of AGG2 used for PDCCH scheduling over the measurement period.
,sum(nvl(AGG4_USED_PDCCH,0)) M8011C41 --Total number of AGG4 used for PDCCH scheduling over the measurement period.
,sum(nvl(AGG8_USED_PDCCH,0)) M8011C42 --Total number of AGG8 used for PDCCH scheduling over the measurement period.
,sum(nvl(PRB_USED_PUSCH,0)) M8011C50 --Total number of PRBs used for UL transmissions on PUSCH over the measurement period is updated to this counter. A PRB covers the pair of resource blocks of two consecutive slots in a subframe.
,avg(nvl(PRB_USED_PUSCH,0)) M8011C50avg
,sum(nvl(CA_SCELL_CONFIG_ATT,0)) M8011C67
,sum(nvl(CA_SCELL_CONFIG_SUCC,0)) M8011C68

        from 
             NOKLTE_PS_LCELLR_MNC1_raw PMRAW
        where
        
         period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
            --- to_char(period_start_time,'yyyymmddHH24MI')  >= to_char(SYSDATE-1,'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID


) M8011 ,
(
select
             to_char(period_start_time,'yyyymmddHH24MI') sdate
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
            --- to_char(period_start_time,'yyyymmddHH24MI')  >= to_char(SYSDATE-1,'yyyymmddHH24MI')
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
             
             
) comm
,(
select
             to_char(period_start_time,'yyyymmddHH24MI') sdatetime
            -- ,MRBTS_ID
             ,LNBTS_ID
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
    ,avg(nvl(RRC_CONNECTED_UE_AVG,0)) M8051C55    --This measurement provides the number of Inter System Handover attempts to GERAN with SRVCC (Single Radio Voice Call Continuity, 3GPP TS 23.216).
    ,max(nvl(RRC_CONNECTED_UE_MAX,0)) M8051C56    --This measurement provides the number of successful Inter System Handover completions to GERAN with SRVCC (Single Radio Voice Call Continuity, 3GPP TS 23.216).
    ,avg(nvl(CELL_LOAD_ACTIVE_UE_AVG,0)) M8051C57
    ,max(nvl(CELL_LOAD_ACTIVE_UE_MAX,0)) M8051C58
   ,avg(nvl(DL_UE_DATA_BUFFER_AVG,0)) M8051C107
   ,max(nvl(DL_UE_DATA_BUFFER_MAX,0)) M8051C108
   ,avg(nvl(UL_UE_DATA_BUFFER_AVG,0)) M8051C109
   ,max(nvl(UL_UE_DATA_BUFFER_MAX,0)) M8051C110
,sum(nvl(SUM_ACT_UE,0)) M8051C62
,sum(nvl(DENOM_ACT_UE,0)) M8051C63
,case when max(nvl(CELL_LOAD_ACTIVE_UE_MAX,0)) >= 300 and max(nvl(CELL_LOAD_ACTIVE_UE_MAX,0)) is not null then 1 else 0 end 是否超300用户M8051

            from
            NOKLTE_PS_LUEQ_MNC1_RAW  PMRAW  
        where
             period_start_time between to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24MI') and to_date(TO_CHAR(SYSDATE+1,'YYYYMMDD'),'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),MRBTS_ID,LNBTS_ID,LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8051
,
(select BTS.CO_OBJECT_INSTANCE enb_id_pm,
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
WHERE      comm.cel_key_id=m8001.cel_key_id(+)
       AND comm.cel_key_id=m8011.cel_key_id(+)
	   AND comm.cel_key_id=m8012.cel_key_id(+)
       AND comm.cel_key_id=m8051.cel_key_id(+)
       AND comm.enb_id=pm.enb_id_pm(+)

)
WHERE  enb_id between '0' and '999999'  
--and enb_id in ('822539')
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
substr(sdate,1,12),
city,enb_cell,enb_id,bts_version,cel_name,mtCellThruput_8012
ORDER BY city,substr(sdate,1,12)--,enb_cell,enb_id
)
group by
substr(sdate,1,8)
,enb_cell
,enb_id
,bts_version
,cel_name 
,mtCellThruput_8012
having
sum(业务量GB) between 13.5 and 15
and max(RRC最大连接数) > 200
and max(有效RRC连接最大数) >40
and (
max(上行PRB平均利用率new) > 50
or max(下行PRB平均利用率new) > 50
or max(PDCCH信道CCE占用率) > 50
)
and mtCellThruput_8012 != 'disable'
