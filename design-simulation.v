module parking_place (
    input wire clk,        
    input wire reset,      
    input wire car_arrival, 
    input wire car_depart,  
    output reg [3:0] cars_parked, 
    output reg [3:0] spaces_left, 
    output reg parking_full 
);

// Define states
parameter IDLE = 3'b000;
parameter PARK = 3'b001;
parameter DEPART = 3'b010;

// State registers
reg [2:0] current_state;
reg [2:0] next_state;

// Counters
reg [3:0] cars_parked_reg;
reg [3:0] spaces_left_reg;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        current_state <= IDLE;
        cars_parked_reg <= 0;
        spaces_left_reg <= 5; // 5 car parking space available 
        parking_full <= 0;
    end else begin
        current_state <= next_state;
        cars_parked_reg <= cars_parked;
        spaces_left_reg <= spaces_left;
    end
end

always @(*) begin
    case (current_state)
        IDLE: begin
            next_state = car_arrival ? PARK : IDLE;
        end
        PARK: begin
            next_state = car_depart ? DEPART : PARK;
        end
        DEPART: begin
            next_state = car_arrival ? PARK : DEPART;
        end
    endcase
end

always @(posedge clk) begin
    if (current_state == PARK && spaces_left_reg > 0) begin
        cars_parked_reg <= cars_parked_reg + 1;
        spaces_left_reg <= spaces_left_reg - 1;
    end else if (current_state == DEPART && cars_parked_reg > 0) begin
        cars_parked_reg <= cars_parked_reg - 1;
        spaces_left_reg <= spaces_left_reg + 1;
    end
end

assign cars_parked = cars_parked_reg;
assign spaces_left = spaces_left_reg;

always @(*) begin
  parking_full = (spaces_left_reg == 0) && (cars_parked_reg == 5); // when 5 cars occupy 
end

endmodule
