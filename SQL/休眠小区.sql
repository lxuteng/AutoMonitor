Select
       --case  when ((lnbts.co_object_instance>='659712' and lnbts.co_object_instance<='660223' ) or (lnbts.co_object_instance >= '684032' and lnbts.co_object_instance <='684287' ) or(lnbts.co_object_instance>= '701184' and lnbts.co_object_instance<='701951' ) or (lnbts.co_object_instance>= '716800' and lnbts.co_object_instance<='717055' )or (lnbts.co_object_instance>= '201728' and lnbts.co_object_instance<='201983' )or (lnbts.co_object_instance >='822528' and lnbts.co_object_instance <='823807')or (lnbts.co_object_instance >='837888' and lnbts.co_object_instance <='838399')or (lnbts.co_object_instance >='340736' and lnbts.co_object_instance <='341247')or (lnbts.co_object_instance >='561920' and lnbts.co_object_instance <='562431')) then '³±ÖÝ' 
       --      else 'NA'     
       --end area
       p.period_start_time
      ,lnbts.co_object_instance                                                        enb_id
      ,lncel.co_object_instance                                                        cel_id
      ,lnbts.co_object_instance||'_'||lncel.co_object_instance enb_cell
      ,lnbts.co_sys_version                                                            sys_version
      ,ipno.ipno_mpia_8                                                                ip_addr
      ,c.smod_product_name bbu
      ,(RACH_STP_ATT_LARGE_MSG+RACH_STP_ATT_SMALL_MSG+RACH_STP_ATT_DEDICATED)       preamble_req
      ,(RACH_STP_COMPLETIONS)                                                       preamble_succ
      ,(nvl(SIGN_CONN_ESTAB_ATT_MO_S,0)+nvl(SIGN_CONN_ESTAB_ATT_MT,0)
           +nvl(SIGN_CONN_ESTAB_ATT_MO_D,0)+nvl(SIGN_CONN_ESTAB_ATT_OTHERS,0)
           +nvl(SIGN_CONN_ESTAB_ATT_EMG,0)+nvl(SIGN_CONN_ESTAB_ATT_HIPRIO,0)
           +nvl(SIGN_CONN_ESTAB_ATT_DEL_TOL,0))                                        rrc_stp_att
      ,(SIGN_CONN_ESTAB_COMP)                                                       rrc_stp_succ
   From
       NOKLTE_PS_LCELLD_MNC1_RAW  p   --PM8001
      ,NOKLTE_PS_LUEST_MNC1_RAW   t   --PM8013
      ,c_lte_ipno         ipno
      ,ctp_common_objects lnbts
      ,ctp_common_objects lncel
      ,ctp_common_objects lnmrbts
      ,ctp_common_objects lnsmod
      ,C_LTE_SMOD c
    Where
          p.period_start_time>=to_date(&1,'yyyymmddhh24mi')
      and p.period_start_time<=to_date(&2,'yyyymmddhh24mi')
      and p.period_start_time=t.period_start_time
      and p.lncel_id=lncel.co_gid and t.lncel_id=p.lncel_id
      and lncel.co_parent_gid=lnbts.co_gid 
      and lnbts.co_parent_gid=lnmrbts.co_gid
      and lnsmod.co_parent_gid=lnmrbts.co_gid
      AND lnbts.CO_STATE<>9 
      and lncel.CO_STATE<>9
      and lnbts.co_object_instance=ipno.ipno_bts_id
      and c.obj_gid=lnsmod.co_gid
     --and c.smod_product_name like 'ASIA%'   
     
     and (RACH_STP_ATT_LARGE_MSG+RACH_STP_ATT_SMALL_MSG+RACH_STP_ATT_DEDICATED)>1000
     and (nvl(SIGN_CONN_ESTAB_ATT_MO_S,0)+nvl(SIGN_CONN_ESTAB_ATT_MT,0)
           +nvl(SIGN_CONN_ESTAB_ATT_MO_D,0)+nvl(SIGN_CONN_ESTAB_ATT_OTHERS,0)
           +nvl(SIGN_CONN_ESTAB_ATT_EMG,0)+nvl(SIGN_CONN_ESTAB_ATT_HIPRIO,0)
           +nvl(SIGN_CONN_ESTAB_ATT_DEL_TOL,0)) =0/**/
        --&3&4&5&6&7&8
