*&---------------------------------------------------------------------*
*& Report ZALE_EXPORT_LOG_BAL
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zale_export_log_bal.

PARAMETERS object   TYPE balhdr-object OBLIGATORY.
PARAMETERS suobject TYPE balhdr-subobject OBLIGATORY.

START-OF-SELECTION.

  DATA filter_values TYPE zif_ale_log_reader=>ty_filter_values.

  filter_values = VALUE #( ( key = 'OBJECT' value = object )
                           ( key = 'SUBOBJECT' value = suobject ) ).


  "read
  DATA(logs) = NEW zcl_ale_log_reader_bal(  )->zif_ale_log_reader~read( filter_values ).

  "convert
  DATA(converted_logs) = NEW zcl_ale_log_converter_gelf( )->zif_ale_log_converter~convert( logs ).

  cl_demo_output=>display( converted_logs ).

  "connect
