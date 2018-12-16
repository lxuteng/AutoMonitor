select 'lnHoG'  ����,
       BTS.CO_OBJECT_INSTANCE enb_id,
       BTS.CO_OBJECT_INSTANCE || '_' || CELL.CO_OBJECT_INSTANCE enb_cell,
       nBTS.CO_NAME bts_name,
       nCELL.Co_Name cell_name,

  BTS.CO_SYS_VERSION VERSION,
       em.em_host_name IP,
       lnbts.LNBTS_ASTG_38 actSrvccToGsm,
       lncel.LNCEL_843R95786AGSMO actGsmSrvccMeasOpt,
       lncel.LNCEL_THLD_4-140 threshold4,

       hog.CO_OBJECT_INSTANCE lnhog_ID,
lnhog.LNHOG_B2T1G_1 b2Threshold1GERAN,
lnhog.LNHOG_B2T2RG_2 b2Threshold2RssiGERAN,
lnhog.LNHOG_HB2TG_5 hysB2ThresholdGERAN,
lnhog.LNHOG_B2TGM_3 b2TimeToTriggerGERANMeas,
lnhog.LNHOG_REP_INT_GERAN reportIntervalGERAN,
lnhog.LNHOG_B2T1GQ1_8-140 b2Threshold1GERANQci1,
lnhog.LNHOG_B2T2RGQ1_9-110 b2Threshold2RssiGERANQci1
--lnhog.AVLG2_AVLG_1 arfcnValueListGERAN


          
  from c_lte_lnhog lnhog, ---lnHoG
       ctp_common_objects BTS,   --��վ������
       ctp_common_objects CELL,  --С��������
       ctp_common_objects hog,  --С��������
       UTP_COMMON_OBJECTS nBTS,  --��վ������
       UTP_COMMON_OBJECTS nCELL, --С��������
       nasda_objects nao,
       nasda_objects emo,
       nd_in_em em,   --IP ��վ�汾        
       c_lte_lnbts lnbts, --��վ������
       c_lte_lncel lncel  --С��������
       
  where --(BTS.CO_OC_ID = 2860 or BTS.CO_OC_ID = 2140 or BTS.CO_OC_ID = 2252) --��վ
        --and (CELL.CO_OC_ID = 2881 or  CELL.CO_OC_ID = 2148 or  CELL.CO_OC_ID = 2260) --С��
        --and (hog.co_oc_id = 2878 or hog.co_oc_id = 2204 or hog.co_oc_id = 2316) --hog
        
        --and  
        BTS.CO_GID = cell.CO_PARENT_GID  --������վ&С��
        and  cell.co_gid = hog.CO_PARENT_GID   --����С��&lnhog
        and nBTS.CO_GID = BTS.CO_GID  --������վ����&��վ
        and nCELL.co_GID = CELL.co_gid  --����С������&С��
        and nao.co_gid=bts.co_gid 
        and em.obj_gid=emo.co_gid 
        and emo.co_parent_gid=nao.co_gid   --����IP&��վ
        and lnbts.OBJ_GID = bts.CO_GID  --������վ����&��վ
        and lncel.OBJ_GID = cell.CO_GID  --����С������&С��
        and lnhog.OBJ_GID = hog.CO_GID   --����hog����&hog
        and lnbts.CONF_ID =1  --��վ����״̬
        and lncel.CONF_ID =1  --С������״̬
        and lnhog.CONF_ID =1  --hog����״̬
        --&1
