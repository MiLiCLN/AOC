class ZCL_AOC_CHECK_60 definition
  public
  inheriting from ZCL_AOC_SUPER
  create public .

public section.

  methods CONSTRUCTOR .

  methods CHECK
    redefinition .
  methods GET_MESSAGE_TEXT
    redefinition .
protected section.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AOC_CHECK_60 IMPLEMENTATION.


  METHOD check.

* abapOpenChecks
* https://github.com/larshp/abapOpenChecks
* MIT License

    DATA: lt_statements TYPE ty_statements,
          lv_index      TYPE i,
          lt_tokens     LIKE it_tokens,
          lv_code       TYPE sci_errc.

    FIELD-SYMBOLS: <ls_token>     LIKE LINE OF it_tokens,
                   <ls_statement> LIKE LINE OF lt_statements.


    lt_tokens = it_tokens.
    LOOP AT lt_tokens ASSIGNING <ls_token> WHERE type = scan_token_type-literal.
      <ls_token>-str = 'STR'.
    ENDLOOP.

    lt_statements = build_statements(
      it_tokens     = lt_tokens
      it_statements = it_statements
      it_levels     = it_levels ).

    LOOP AT lt_statements ASSIGNING <ls_statement>.

      CLEAR lv_code.

      IF <ls_statement>-str CP '* && |*' OR <ls_statement>-str CP '*| && *'.
        lv_code = '001'.
      ENDIF.

      IF NOT lv_code IS INITIAL.
        inform( p_sub_obj_type = c_type_include
                p_sub_obj_name = <ls_statement>-include
                p_line         = <ls_statement>-start-row
                p_kind         = mv_errty
                p_test         = myname
                p_code         = lv_code ).
      ENDIF.
    ENDLOOP.

  ENDMETHOD.


  METHOD CONSTRUCTOR.

    super->constructor( ).

    description = 'Concatenation of string templates'. "#EC NOTEXT
    category    = 'ZCL_AOC_CATEGORY'.
    version     = '001'.
    position    = '060'.

    has_attributes = abap_true.
    attributes_ok  = abap_true.

    mv_errty   = c_error.

  ENDMETHOD.                    "CONSTRUCTOR


  METHOD get_message_text.

    CLEAR p_text.

    CASE p_code.
      WHEN '001'.
        p_text = 'Concatenation of string templates'.       "#EC NOTEXT
      WHEN OTHERS.
        super->get_message_text( EXPORTING p_test = p_test
                                           p_code = p_code
                                 IMPORTING p_text = p_text ).
    ENDCASE.

  ENDMETHOD.
ENDCLASS.
