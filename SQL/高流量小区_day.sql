select 
substr(sdate,1,8) sdate
,enb_cell
,enb_id
,bts_version
,cel_name
,sum(ҵ����GB) ҵ����GB
,max(RRC���������) RRC���������
,max(��ЧRRC���������) ��ЧRRC���������
,max(����PRBƽ��������new) ����PRBƽ��������new
,max(����PRBƽ��������new) ����PRBƽ��������new
,max(PDCCH�ŵ�CCEռ����) PDCCH�ŵ�CCEռ����
from
(
SELECT
substr(sdate,1,10) sdate
,
city
,enb_cell,enb_id,bts_version,cel_name
,Round(sum(M8012C19+M8012C20)/(1000*1000*1000),2)   ҵ����GB
,Round(sum(M8012C19)/(1024),2)   �û���PDCP����������KB
,Round(sum(M8012C20)/(1024),2)   �û���PDCP����������KB
,max(��󼤻��û���)  ��󼤻��û���       
,max(RRC���������)  RRC��������� 
,case when max(������ЧRRC���������)>max(������ЧRRC���������) then max(������ЧRRC���������) else max(������ЧRRC���������) end ��ЧRRC���������
,round(decode(sum(M8011C38),0,0,(sum(M8011C39)*1+sum(M8011C40)*2+sum(M8011C41)*4+sum(M8011C42)*8)/sum(M8011C38)*100),2) PDCCH�ŵ�CCEռ����
,case when length(TO_CHAR(SYSDATE-1,'YYYYMMDD'))=8 and length(TO_CHAR(SYSDATE,'YYYYMMDD'))=8 then round(decode(avg(M8001C217)+ avg(M8001C216),0,0,(avg(M8011C50)/(24*60*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)/(avg(M8001C217)+ avg(M8001C216)))*100,2) 
      when length(TO_CHAR(SYSDATE-1,'YYYYMMDD'))=10 and length(TO_CHAR(SYSDATE,'YYYYMMDD'))=10 then round(decode(avg(M8001C217)+ avg(M8001C216),0,0,(avg(M8011C50)/(60*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)/(avg(M8001C217)+ avg(M8001C216)))*100,2)
      when length(TO_CHAR(SYSDATE-1,'YYYYMMDD'))=12 and length(TO_CHAR(SYSDATE,'YYYYMMDD'))=12 then round(decode(avg(M8001C217)+ avg(M8001C216),0,0,(avg(M8011C50)/(15*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)/(avg(M8001C217)+ avg(M8001C216)))*100,2)
end ����������  --2017��10��13�ո���
,case when length(TO_CHAR(SYSDATE-1,'YYYYMMDD'))=8 and length(TO_CHAR(SYSDATE,'YYYYMMDD'))=8 then round(avg(M8011C50)/(24*60*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)
      when length(TO_CHAR(SYSDATE-1,'YYYYMMDD'))=10 and length(TO_CHAR(SYSDATE,'YYYYMMDD'))=10 then round(avg(M8011C50)/(60*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)
      when length(TO_CHAR(SYSDATE-1,'YYYYMMDD'))=12 and length(TO_CHAR(SYSDATE,'YYYYMMDD'))=12 then round(avg(M8011C50)/(15*60*1000*1/5) + avg(M8011C37)/10*avg(M8001C216)/100)
end ���������ʷ���  --2017��10��13�ո���
,round(avg(M8001C217)+ avg(M8001C216),0) ���������ʷ�ĸ


--,decode(avg(M8001C217),0,0,round(100*avg(M8011C50avg)/(24*60*60*1000/5)/avg(M8001C217),2)) ����PRBƽ��������new  --day
--,avg(M8011C50avg) ����PRBƽ�������ʷ���  --day
--,24*60*60*1000/5*avg(M8001C217) ����PRBƽ�������ʷ�ĸ  --day
,decode(avg(M8001C217),0,0,round(100*avg(M8011C50avg)/(60*60*1000/5)/avg(M8001C217),2)) ����PRBƽ��������new  --hour
,avg(M8011C50avg) ����PRBƽ�������ʷ���  --hour
,60*60*1000/5*avg(M8001C217) ����PRBƽ�������ʷ�ĸ  --hour
--,decode(avg(M8001C217),0,0,round(100*avg(M8011C50avg)/(15*60*1000/5)/avg(M8001C217),2)) ����PRBƽ��������new  --raw
--,avg(M8011C50avg) ����PRBƽ�������ʷ���  --raw
--,15*60*1000/5*avg(M8001C217) ����PRBƽ�������ʷ�ĸ  --raw


,round(avg(M8011C37)/10,2) ����PRBƽ��������new 


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
,case when bts_version = 'TL16A' or bts_version = 'TLF16A' then M8051C57
 else M8001C223 end ƽ�������û��� 
,case when bts_version = 'TL16A' or bts_version = 'TLF16A' then M8051C58
 else M8001C224 end ��󼤻��û���     
,case when bts_version = 'TL16A' or bts_version = 'TLF16A' then M8051C56
 else M8001C200 end   RRC��������� 
   
,case when (bts_version='TL16A' or bts_version = 'TLF16A') then M8051C107/100
      else M8001C147/100 end ������ЧRRC����ƽ���� 
,case when (bts_version='TL16A' or bts_version = 'TLF16A') then M8051C109/100
      else M8001C150/100 end ������ЧRRC����ƽ����        
,case when (bts_version='TL16A' or bts_version = 'TLF16A') then M8051C108
      else M8001C148 end ������ЧRRC���������
,case when (bts_version='TL16A' or bts_version = 'TLF16A') then M8051C110
      else M8001C151 end ������ЧRRC���������  





		
FROM
( select
             to_char(period_start_time,'yyyymmddHH24') sdate
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24')||LNCEL_ID cel_key_id
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
,case when max(nvl(CELL_LOAD_ACT_UE_MAX,0)) >= 300 and max(nvl(CELL_LOAD_ACT_UE_MAX,0)) is not null then 1 else 0 end �Ƿ�300�û�M8001

FROM NOKLTE_PS_LCELLD_lncel_hour PMRAW
        where
             ---to_char(period_start_time,'yyyymmddHH24') >= to_char(SYSDATE-1,'yyyymmddHH24')
         period_start_time between to_date(TO_CHAR(SYSDATE-1,'YYYYMMDD'),'yyyymmddHH24') and to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24')
            -- and to_char(period_start_time,'yyyymmddHH24') <= to_char(SYSDATE-1,'yyyymmddHH24')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24')||LNCEL_ID
)M8001

,


(
select
             to_char(period_start_time,'yyyymmddHH24') sdate
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24')||LNCEL_ID cel_key_id
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
             NOKLTE_PS_LCELLR_lncel_hour PMRAW
        where
        
         period_start_time between to_date(TO_CHAR(SYSDATE-1,'YYYYMMDD'),'yyyymmddHH24') and to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24')
            --- to_char(period_start_time,'yyyymmddHH24')  >= to_char(SYSDATE-1,'yyyymmddHH24')
            -- and to_char(period_start_time,'yyyymmddHH24') <= to_char(SYSDATE-1,'yyyymmddHH24')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24')||LNCEL_ID


) M8011 ,
(
select
             to_char(period_start_time,'yyyymmddHH24') sdate
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24')||LNCEL_ID cel_key_id
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
             NOKLTE_PS_LCELLT_lncel_hour PMRAW
        where
        
         period_start_time between to_date(TO_CHAR(SYSDATE-1,'YYYYMMDD'),'yyyymmddHH24') and to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24')
            --- to_char(period_start_time,'yyyymmddHH24')  >= to_char(SYSDATE-1,'yyyymmddHH24')
            -- and to_char(period_start_time,'yyyymmddHH24') <= to_char(SYSDATE-1,'yyyymmddHH24')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24')||LNCEL_ID


) M8012,
(
select
to_char(period_start_time,'yyyymmddHH24') sdate
,LNCEL_ID
,to_char(period_start_time,'yyyymmddHH24')||LNCEL_ID cel_key_id
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
Select lnbts_id,lncel_id,period_start_time from NOKLTE_PS_LRDB_lncel_hour m8007
Union
Select lnbts_id,lncel_id,period_start_time from NOKLTE_PS_LCELAV_lncel_hour m8020
)
) comm,
ctp_common_objects lnbts,
ctp_common_objects lncel
where 
comm.period_start_time between to_date(TO_CHAR(SYSDATE-1,'YYYYMMDD'),'yyyymmddHH24') and to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24')

and comm.lnbts_id=lnbts.co_gid
AND comm.LNCEL_ID=lncel.co_gid
AND lnbts.CO_STATE<>9 
AND lncel.CO_STATE<>9
             
             
)comm
,(
select
             to_char(period_start_time,'yyyymmddHH24') sdatetime
            -- ,MRBTS_ID
             ,LNBTS_ID
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24')||LNCEL_ID cel_key_id
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
,case when max(nvl(CELL_LOAD_ACTIVE_UE_MAX,0)) >= 300 and max(nvl(CELL_LOAD_ACTIVE_UE_MAX,0)) is not null then 1 else 0 end �Ƿ�300�û�M8051

            from
            NOKLTE_PS_LUEQ_lncel_hour  PMRAW  
        where
             period_start_time between to_date(TO_CHAR(SYSDATE-1,'YYYYMMDD'),'yyyymmddHH24') and to_date(TO_CHAR(SYSDATE,'YYYYMMDD'),'yyyymmddHH24')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24'),MRBTS_ID,LNBTS_ID,LNCEL_ID,to_char(period_start_time,'yyyymmddHH24')||LNCEL_ID
)M8051
WHERE      comm.cel_key_id=m8001.cel_key_id(+)
       AND comm.cel_key_id=m8011.cel_key_id(+)
       AND comm.cel_key_id=m8012.cel_key_id(+)
       AND comm.cel_key_id=m8051.cel_key_id(+)

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
substr(sdate,1,10),
city,enb_cell,enb_id,bts_version,cel_name
ORDER BY city,substr(sdate,1,10)--,enb_cell,enb_id
)
group by
substr(sdate,1,8)
,enb_cell
,enb_id
,bts_version
,cel_name 
having
sum(ҵ����GB)>15
and max(RRC���������) > 200
and max(��ЧRRC���������) >40
and (
max(����PRBƽ��������new) > 50
or max(����PRBƽ��������new) > 50
or max(PDCCH�ŵ�CCEռ����) > 50
)
