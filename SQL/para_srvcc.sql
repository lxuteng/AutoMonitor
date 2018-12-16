select 'lnHoG'  级别,
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
       ctp_common_objects BTS,   --基站级索引
       ctp_common_objects CELL,  --小区级索引
       ctp_common_objects hog,  --小区级索引
       UTP_COMMON_OBJECTS nBTS,  --基站级名字
       UTP_COMMON_OBJECTS nCELL, --小区级名字
       nasda_objects nao,
       nasda_objects emo,
       nd_in_em em,   --IP 基站版本        
       c_lte_lnbts lnbts, --基站级参数
       c_lte_lncel lncel  --小区级参数
       
  where --(BTS.CO_OC_ID = 2860 or BTS.CO_OC_ID = 2140 or BTS.CO_OC_ID = 2252) --基站
        --and (CELL.CO_OC_ID = 2881 or  CELL.CO_OC_ID = 2148 or  CELL.CO_OC_ID = 2260) --小区
        --and (hog.co_oc_id = 2878 or hog.co_oc_id = 2204 or hog.co_oc_id = 2316) --hog
        
        --and  
        BTS.CO_GID = cell.CO_PARENT_GID  --关联基站&小区
        and  cell.co_gid = hog.CO_PARENT_GID   --关联小区&lnhog
        and nBTS.CO_GID = BTS.CO_GID  --关联基站名称&基站
        and nCELL.co_GID = CELL.co_gid  --关联小区名称&小区
        and nao.co_gid=bts.co_gid 
        and em.obj_gid=emo.co_gid 
        and emo.co_parent_gid=nao.co_gid   --关联IP&基站
        and lnbts.OBJ_GID = bts.CO_GID  --关联基站参数&基站
        and lncel.OBJ_GID = cell.CO_GID  --关联小区参数&小区
        and lnhog.OBJ_GID = hog.CO_GID   --关联hog参数&hog
        and lnbts.CONF_ID =1  --基站参数状态
        and lncel.CONF_ID =1  --小区参数状态
        and lnhog.CONF_ID =1  --hog参数状态
        --&1
