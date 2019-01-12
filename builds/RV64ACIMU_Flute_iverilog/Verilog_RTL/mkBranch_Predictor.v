//
// Generated by Bluespec Compiler, version 2017.07.A (build 1da80f1, 2017-07-21)
//
// On Sat Jan 12 00:00:15 EST 2019
//
//
// Ports:
// Name                         I/O  size props
// RDY_reset                      O     1 const
// RDY_predict_req                O     1
// predict_rsp                    O    64
// CLK                            I     1 clock
// RST_N                          I     1 reset
// predict_req_pc                 I    64
// predict_req_m_old_pc           I    65
// EN_reset                       I     1
// EN_predict_req                 I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkBranch_Predictor(CLK,
			  RST_N,

			  EN_reset,
			  RDY_reset,

			  predict_req_pc,
			  predict_req_m_old_pc,
			  EN_predict_req,
			  RDY_predict_req,

			  predict_rsp);
  input  CLK;
  input  RST_N;

  // action method reset
  input  EN_reset;
  output RDY_reset;

  // action method predict_req
  input  [63 : 0] predict_req_pc;
  input  [64 : 0] predict_req_m_old_pc;
  input  EN_predict_req;
  output RDY_predict_req;

  // value method predict_rsp
  output [63 : 0] predict_rsp;

  // signals for module outputs
  wire [63 : 0] predict_rsp;
  wire RDY_predict_req, RDY_reset;

  // register cfg_verbosity
  reg [31 : 0] cfg_verbosity;
  wire [31 : 0] cfg_verbosity$D_IN;
  wire cfg_verbosity$EN;

  // register rg_index
  reg [8 : 0] rg_index;
  wire [8 : 0] rg_index$D_IN;
  wire rg_index$EN;

  // register rg_pc
  reg [63 : 0] rg_pc;
  wire [63 : 0] rg_pc$D_IN;
  wire rg_pc$EN;

  // register rg_resetting
  reg rg_resetting;
  wire rg_resetting$D_IN, rg_resetting$EN;

  // ports of submodule bramcore2
  wire [117 : 0] bramcore2$DIA, bramcore2$DIB, bramcore2$DOA;
  wire [8 : 0] bramcore2$ADDRA, bramcore2$ADDRB;
  wire bramcore2$ENA, bramcore2$ENB, bramcore2$WEA, bramcore2$WEB;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_reset,
       CAN_FIRE_predict_req,
       CAN_FIRE_reset,
       WILL_FIRE_RL_rl_reset,
       WILL_FIRE_predict_req,
       WILL_FIRE_reset;

  // inputs to muxes for submodule ports
  wire [117 : 0] MUX_bramcore2$b_put_3__VAL_1;
  wire [8 : 0] MUX_rg_index$write_1__VAL_2;
  wire MUX_bramcore2$b_put_1__SEL_1;

  // remaining internal signals
  reg [31 : 0] v__h400, v__h406;
  wire [63 : 0] pred_pc__h1011, pred_pc__h1012;
  wire NOT_cfg_verbosity_read_SLE_1___d6;

  // action method reset
  assign RDY_reset = 1'd1 ;
  assign CAN_FIRE_reset = 1'd1 ;
  assign WILL_FIRE_reset = EN_reset ;

  // action method predict_req
  assign RDY_predict_req = !rg_resetting ;
  assign CAN_FIRE_predict_req = !rg_resetting ;
  assign WILL_FIRE_predict_req = EN_predict_req ;

  // value method predict_rsp
  assign predict_rsp =
	     (bramcore2$DOA[117] && bramcore2$DOA[116:63] == rg_pc[63:10]) ?
	       pred_pc__h1011 :
	       pred_pc__h1012 ;

  // submodule bramcore2
  BRAM2 #(.PIPELINED(1'd0),
	  .ADDR_WIDTH(32'd9),
	  .DATA_WIDTH(32'd118),
	  .MEMSIZE(10'd512)) bramcore2(.CLKA(CLK),
				       .CLKB(CLK),
				       .ADDRA(bramcore2$ADDRA),
				       .ADDRB(bramcore2$ADDRB),
				       .DIA(bramcore2$DIA),
				       .DIB(bramcore2$DIB),
				       .WEA(bramcore2$WEA),
				       .WEB(bramcore2$WEB),
				       .ENA(bramcore2$ENA),
				       .ENB(bramcore2$ENB),
				       .DOA(bramcore2$DOA),
				       .DOB());

  // rule RL_rl_reset
  assign CAN_FIRE_RL_rl_reset = rg_resetting ;
  assign WILL_FIRE_RL_rl_reset = rg_resetting ;

  // inputs to muxes for submodule ports
  assign MUX_bramcore2$b_put_1__SEL_1 =
	     EN_predict_req && predict_req_m_old_pc[64] ;
  assign MUX_bramcore2$b_put_3__VAL_1 =
	     { 1'd1, predict_req_m_old_pc[63:10], predict_req_pc[63:1] } ;
  assign MUX_rg_index$write_1__VAL_2 = rg_index + 9'd1 ;

  // register cfg_verbosity
  assign cfg_verbosity$D_IN = 32'h0 ;
  assign cfg_verbosity$EN = 1'b0 ;

  // register rg_index
  assign rg_index$D_IN = EN_reset ? 9'd0 : MUX_rg_index$write_1__VAL_2 ;
  assign rg_index$EN = rg_resetting || EN_reset ;

  // register rg_pc
  assign rg_pc$D_IN = predict_req_pc ;
  assign rg_pc$EN = EN_predict_req ;

  // register rg_resetting
  assign rg_resetting$D_IN = EN_reset ;
  assign rg_resetting$EN = rg_resetting && rg_index == 9'd511 || EN_reset ;

  // submodule bramcore2
  assign bramcore2$ADDRA = predict_req_pc[9:1] ;
  assign bramcore2$ADDRB =
	     MUX_bramcore2$b_put_1__SEL_1 ?
	       predict_req_m_old_pc[9:1] :
	       rg_index ;
  assign bramcore2$DIA =
	     118'h2AAAAAAAAAAAAAAAAAAAAAAAAAAAAA /* unspecified value */  ;
  assign bramcore2$DIB =
	     MUX_bramcore2$b_put_1__SEL_1 ?
	       MUX_bramcore2$b_put_3__VAL_1 :
	       118'd0 ;
  assign bramcore2$WEA = 1'd0 ;
  assign bramcore2$WEB = 1'd1 ;
  assign bramcore2$ENA = EN_predict_req ;
  assign bramcore2$ENB =
	     EN_predict_req && predict_req_m_old_pc[64] || rg_resetting ;

  // remaining internal signals
  assign NOT_cfg_verbosity_read_SLE_1___d6 =
	     (cfg_verbosity ^ 32'h80000000) > 32'h80000001 ;
  assign pred_pc__h1011 = { bramcore2$DOA[62:0], 1'b0 } ;
  assign pred_pc__h1012 = rg_pc + 64'd4 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        cfg_verbosity <= `BSV_ASSIGNMENT_DELAY 32'd0;
	rg_index <= `BSV_ASSIGNMENT_DELAY 9'd0;
	rg_resetting <= `BSV_ASSIGNMENT_DELAY 1'd1;
      end
    else
      begin
        if (cfg_verbosity$EN)
	  cfg_verbosity <= `BSV_ASSIGNMENT_DELAY cfg_verbosity$D_IN;
	if (rg_index$EN) rg_index <= `BSV_ASSIGNMENT_DELAY rg_index$D_IN;
	if (rg_resetting$EN)
	  rg_resetting <= `BSV_ASSIGNMENT_DELAY rg_resetting$D_IN;
      end
    if (rg_pc$EN) rg_pc <= `BSV_ASSIGNMENT_DELAY rg_pc$D_IN;
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    cfg_verbosity = 32'hAAAAAAAA;
    rg_index = 9'h0AA;
    rg_pc = 64'hAAAAAAAAAAAAAAAA;
    rg_resetting = 1'h0;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on

  // handling of system tasks

  // synopsys translate_off
  always@(negedge CLK)
  begin
    #0;
    if (RST_N != `BSV_RESET_VALUE)
      if (EN_predict_req && NOT_cfg_verbosity_read_SLE_1___d6)
	$display("    Branch_Predictor.predict_req (pc 0x%0h)",
		 predict_req_pc);
    if (RST_N != `BSV_RESET_VALUE)
      if (EN_predict_req && predict_req_m_old_pc[64] &&
	  NOT_cfg_verbosity_read_SLE_1___d6)
	$display("        insert prediction [0x%0h] <= (from pc 0x%0h, to pc 0x%0h)",
		 predict_req_m_old_pc[9:1],
		 predict_req_m_old_pc[63:0],
		 predict_req_pc);
    if (RST_N != `BSV_RESET_VALUE)
      if (rg_resetting && rg_index == 9'd511 &&
	  NOT_cfg_verbosity_read_SLE_1___d6)
	begin
	  v__h406 = $stime;
	  #0;
	end
    v__h400 = v__h406 / 32'd10;
    if (RST_N != `BSV_RESET_VALUE)
      if (rg_resetting && rg_index == 9'd511 &&
	  NOT_cfg_verbosity_read_SLE_1___d6)
	$display("%0d: Branch Predictor: reset complete", v__h400);
  end
  // synopsys translate_on
endmodule  // mkBranch_Predictor

