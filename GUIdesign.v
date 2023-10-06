`timescale 1ns/1ps
module ParkingSystem(
    input wire clk,
    input wire reset,
    input wire ultrasonic_sensor,
    output reg [1:0] car_count,
    output reg [1:0] empty_space,
    output wire [7:0] lcd_data,
    output wire lcd_enable,
    output wire lcd_rs
);

reg [1:0] car_count_internal;
reg [1:0] empty_space_internal;
reg [1:0] parking_status;
reg [7:0] lcd_data_internal;
reg lcd_enable_internal;
reg lcd_rs_internal;

always @(posedge clk or posedge reset) begin
    if (reset) begin
        car_count_internal <= 2'b00;
        empty_space_internal <= 2'b11;
    end else begin
        if (ultrasonic_sensor) begin
            if (empty_space_internal > 0) begin
                car_count_internal <= car_count_internal + 1;
                empty_space_internal <= empty_space_internal - 1;
                parking_status <= 2'b01;
                lcd_data_internal <= 8'b00110000;
                lcd_enable_internal <= 1'b1;
                lcd_rs_internal <= 1'b1;
            end else begin
                parking_status <= 2'b00;
                lcd_data_internal <= 8'b00101110;
                lcd_enable_internal <= 1'b1;
                lcd_rs_internal <= 1'b1;
            end
        end else begin
            parking_status <= 2'b00;
            lcd_data_internal <= 8'b00101110;
            lcd_enable_internal <= 1'b1;
            lcd_rs_internal <= 1'b1;
        end
    end
end

assign car_count = car_count_internal;
assign empty_space = empty_space_internal;
assign lcd_data = lcd_data_internal;
assign lcd_enable = lcd_enable_internal;
assign lcd_rs = lcd_rs_internal;

endmodule
