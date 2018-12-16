SELECT
substr(sdate,1,10)*100+to_char(trunc(to_number(substr(sdate,11,2)/15))*15,'00') sdate
,
city
,enb_cell,enb_id,bts_version,cel_name


,Round(Decode(sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21),0,0,100*sum(M8013C5)/sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21+M8013C31+ M8013C34)),2)  RRC连接建立成功率  --0409修改增加了+M8013C31+ M8013C34
--,Round(Decode(sum(M8006C0),0,0,100*sum(M8006C1)/sum(M8006C0)),2)  ERAB建立成功率
--,Round(Decode(sum(M8006C0),0,0,100*sum(M8006C0-M8006C3-M8006C4-M8006C5)/sum(M8006C0)),2)  ERAB建立成功率
,Round(Decode(sum(M8006C0),0,100,100*sum(ERAB建立成功率分子)/sum(M8006C0)),4)  ERAB建立成功率  --2017年7月31日更新
--,round(Round(Decode(sum(M8006C0),0,0,100*sum(M8006C1)/sum(M8006C0)),2)*Round(Decode(sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21),0,0,100*sum(M8013C5)/sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21)),2)/100,2)  无线接通率
,round(Round(Decode(sum(M8006C0),0,0,100*sum(M8006C0-M8006C3-M8006C4-M8006C5)/sum(M8006C0)),2)*Round(Decode(sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21),0,0,100*sum(M8013C5)/sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21)),2)/100,2)  无线接通率

,Round(decode(sum(radio_drop_deno),0,0,100*sum(radio_drop_num)/sum(radio_drop_deno)),2) 无线掉线率
,round(decode(sum(M8006C1+M8001C223),0,0,100*sum(ERAB_drop_deno)/sum(M8006C1+M8001C223)),2) ERAB掉线率   --这公式和亿阳结果基本一致

,round(avg(平均激活用户数),2) 平均激活用户数
,max(最大激活用户数)  最大激活用户数       
,max(RRC最大连接数)  RRC最大连接数 
-- ,'{*_*}' 容量类
 ,max(M8006C224) QCI1最大用户数
 ,max(M8006C225) QCI2最大用户数 
,sum(拥塞次数) 拥塞次数
--,sum(M8013C65) 控制面过负荷拥塞
--,sum(M8013C66) 用户面过负荷拥塞
--,sum(M8013C67) PUCCH资源不足拥塞
--,sum(M8013C68) 最大RRC受限拥塞
--,sum(M8013C69) MME过负荷拥塞
,case when round(avg(上行有效RRC连接平均数),2)>round(avg(下行有效RRC连接平均数),2) then round(avg(上行有效RRC连接平均数),2) else round(avg(下行有效RRC连接平均数),2) end 有效RRC连接平均数
,case when max(上行有效RRC连接最大数)>max(下行有效RRC连接最大数) then max(上行有效RRC连接最大数) else max(下行有效RRC连接最大数) end 有效RRC连接最大数
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
,M8001C147,M8001C148,M8001C150,M8001C151,M8001C153,M8001C154,M8001C200,M8001C216,M8001C217,M8001C223,M8001C224,M8001C269,m8001c286,M8001C305,M8001C306,M8001C314,M8001C315,M8001C320,M8001C321,M8001C323,M8001C324,M8001C494,M8001C495,M8001C496,m8001c6,m8001c7,M8001C8,M8005C5,M8005C54,M8005C55,M8005C56,M8005C57,M8005C58,M8005C59,M8005C60,M8005C61,M8005C62,M8005C63,M8005C64,M8005C65,M8005C66,M8005C67,M8005C68,M8005C69,M8005C70,M8005C71,M8005C72,M8005C73,M8005C74,M8005C75,M8005C76,M8005C77,M8005C78,M8005C79,M8005C80,M8005C81,M8005C82,M8005C83,M8005C84,M8005C85,M8005C87,M8005C88,M8005C89,M8005C95,M8006C0,M8006C1,M8006C125,M8006C13,M8006C14,M8006C143,M8006C168,M8006C169,M8006C170,M8006C176,M8006C177,M8006C178,M8006C179,M8006C180,M8006C181,M8006C188,M8006C189,M8006C197,M8006C198,M8006C206,M8006C207,M8006C215,M8006C216,M8006C224,M8006C225,M8006C244,M8006C245,M8006C248,M8006C249,M8006C252,M8006C253,M8006C257,M8006C269,M8006C273,M8006C287,M8006C291,M8006C3,M8006C35,M8006C36,M8006C4,M8006C45,M8006C46,M8006C5,M8006C54,M8013C16,M8013C17,M8013C18,M8013C19,M8013C20,M8013C21,M8013C31,M8013C34,M8013C47,M8013C5,M8013C59,M8013C60,M8013C65,M8013C66,M8013C67,M8013C68,M8013C69,M8013C8,M8051C107,M8051C108,M8051C109,M8051C110,M8051C55,M8051C56,M8051C57,M8051C58,M8051C62,M8051C63
--,case when (bts_version='LNT4.0' or bts_version='LNT3.0' ) then M8006C176+M8006C177+M8006C178+M8006C179+M8006C180+M8013C16 
--      else M8006C176+M8006C177+M8006C178+M8006C179+M8006C180+M8013C59+M8013C60 end radio_drop_num --掉线率分子 自适应RL55/45
            
--,case when (bts_version='LNT4.0' or bts_version='LNT3.0' ) then M8006C35+M8006C36+M8006C168+M8006C169+M8006C170+M8001C223 
--     else M8013C47+Decode(M8001C321,0,0,(M8001C320/M8001C321)) end radio_drop_deno --掉线率分母 自适应RL55/45  
,case when (M8013C47='0' ) then M8006C176+M8006C177+M8006C178+M8006C179+M8006C180+M8013C16 

else M8006C176+M8006C177+M8006C178+M8006C179+M8006C180+M8013C59+M8013C60 end radio_drop_num --掉线率分子 自适应RL55/45     
 
,case when (bts_version='TL15A' or bts_version = 'TLF15A' or bts_version='LNT5.0' or bts_version = 'LNZ5.0') then M8013C47+Decode(M8001C321,0,0,(M8001C320/M8001C321))
      else M8013C47+Decode(M8051C63,0,0,(M8051C62/M8051C63))
      end radio_drop_deno --掉线率分母 自适应RL55/TL16A
      
,case when (bts_version='LNT5.0' or bts_version = 'LNZ5.0') then M8013C8 

else M8013C65+M8013C66+M8013C67+M8013C68+M8013C69 end 拥塞次数 --ERAB掉线率分母 自适应RL55/15A 
  
,case when (bts_version='LNT5.0' or bts_version = 'LNZ5.0') then M8016C25+M8006C176+M8006C177+M8006C178+M8006C179+M8006C180+M8006C13+M8006C14 

else M8016C25+M8006C176+M8006C177+M8006C178+M8006C179+M8006C180+M8006C257 end erab_drop_deno --ERAB掉线率分母 自适应RL55/15A 

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


,case when (bts_version='LNT5.0' or bts_version = 'LNZ5.0' or bts_version='TL15A' or bts_version = 'TLF15A') then M8006C0-M8006C3-M8006C4-M8006C5
	else M8006C0-(M8006C244+M8006C248+M8006C245+M8006C249+M8006C252+M8006C253) end ERAB建立成功率分子 

,round(decode(M8006C54,0,M8006C207+M8006C216,M8006C207+M8006C216+M8006C46/M8006C54),0) qci2掉线率分母 --2017年8月28日新增
--2017年9月24日 新增


 
 
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
         period_start_time between to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15,'00'),'yyyymmddHH24MI') and to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15+14,'00'),'yyyymmddHH24MI')
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

         period_start_time between to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15,'00'),'yyyymmddHH24MI') and to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15+14,'00'),'yyyymmddHH24MI')
         
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
,decode(sum(nvl(DENOM_SUM_SIMUL_ERAB,0)),0,0,sum(nvl(SUM_SIMUL_ERAB_QCI_1,0))/sum(nvl(DENOM_SUM_SIMUL_ERAB,0))) 话务量_亿阳


        from
             NOKLTE_PS_LEPSB_MNC1_raw PMRAW
        where
        
         period_start_time between to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15,'00'),'yyyymmddHH24MI') and to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15+14,'00'),'yyyymmddHH24MI')
            ---- to_char(period_start_time,'yyyymmddHH24MI') >= to_char(SYSDATE-1,'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8006
,(
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
             period_start_time between to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15,'00'),'yyyymmddHH24MI') and to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15+14,'00'),'yyyymmddHH24MI')
             
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
,(
select
             to_char(period_start_time,'yyyymmddHH24MI') sdatetime
             ,LNCEL_ID
             ,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID cel_key_id
,sum(nvl(ISYS_HO_FAIL,0)) M8016C25 --Number of failed Inter System Handover attempts.
,sum(nvl(ISYS_HO_GERAN_SRVCC_ATT,0)) M8016C33 --This measurement provides the number of Inter System Handover attempts to GERAN with SRVCC (Single Radio Voice Call Continuity, 3GPP TS 23.216).
,sum(nvl(ISYS_HO_GERAN_SRVCC_SUCC,0)) M8016C34 --This measurement provides the number of successful Inter System Handover completions to GERAN with SRVCC (Single Radio Voice Call Continuity, 3GPP TS 23.216).
,sum(nvl(ISYS_HO_GERAN_SRVCC_FAIL,0)) M8016C35 --This measurement provides the number of failed Inter System Handover attempts to GERAN with SRVCC (Single Radio Voice Call Continuity, 3GPP TS 23.216).
,sum(nvl(ISYS_HO_GERAN_SRVCC_PREP,0)) M8016C54
        from
             NOKLTE_PS_LISHO_MNC1_RAW PMRAW
        where
        period_start_time between to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15,'00'),'yyyymmddHH24MI') and to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15+14,'00'),'yyyymmddHH24MI')
            --- to_char(period_start_time,'yyyymmddHH24MI') >= to_char(SYSDATE-1,'yyyymmddHH24MI')
            -- and to_char(period_start_time,'yyyymmddHH24MI') <= to_char(SYSDATE-1,'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8016
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
             period_start_time between to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15,'00'),'yyyymmddHH24MI') and to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15+14,'00'),'yyyymmddHH24MI')
             --AND PERIOD_DURATION=15
        group by
             to_char(period_start_time,'yyyymmddHH24MI'),MRBTS_ID,LNBTS_ID,LNCEL_ID,to_char(period_start_time,'yyyymmddHH24MI')||LNCEL_ID
)M8051,
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
comm.period_start_time between to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15,'00'),'yyyymmddHH24MI') and to_date(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15+14,'00'),'yyyymmddHH24MI')
and comm.lnbts_id=lnbts.co_gid
AND comm.LNCEL_ID=lncel.co_gid
AND lnbts.CO_STATE<>9 
AND lncel.CO_STATE<>9
) comm
WHERE      comm.cel_key_id=m8001.cel_key_id(+)
       AND comm.cel_key_id=m8005.cel_key_id(+)
       AND comm.cel_key_id=m8006.cel_key_id(+)
       AND comm.cel_key_id=m8013.cel_key_id(+)
       AND comm.cel_key_id=m8016.cel_key_id(+)
       AND comm.cel_key_id=m8051.cel_key_id(+)

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
having
max(RRC最大连接数) between 90 and 100
and (
round(Round(Decode(sum(M8006C0),0,0,100*sum(M8006C0-M8006C3-M8006C4-M8006C5)/sum(M8006C0)),2)*Round(Decode(sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21),0,0,100*sum(M8013C5)/sum(M8013C17+M8013C18+M8013C19+M8013C20+ M8013C21)),2)/100,2) < 95
or 
Round(decode(sum(radio_drop_deno),0,0,100*sum(radio_drop_num)/sum(radio_drop_deno)),2) > 5
)
GROUP BY 
substr(sdate,1,10)*100+to_char(trunc(to_number(substr(sdate,11,2)/15))*15,'00'),
city,enb_cell,enb_id,bts_version,cel_name
ORDER BY city,substr(sdate,1,10)*100+to_char(trunc(to_number(substr(sdate,11,2)/15))*15,'00')--,enb_cell,enb_id


--,substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15,'00')
--,substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),1,10)*100+to_char(trunc(to_number(substr(TO_CHAR(SYSDATE-1/96,'yyyymmddHH24MI'),11,2)/15))*15+14,'00')