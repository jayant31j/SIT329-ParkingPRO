`timescale 1ns/1ps
module Testbench_ParkingSystem;

reg clk;
reg reset;
reg ultrasonic_sensor;
wire [1:0] car_count;
wire [1:0] empty_space;
wire [7:0] lcd_data;
wire lcd_enable;
wire lcd_rs;

integer total_cars;
integer total_empty_spaces;

ParkingSystem parking_system(
    .clk(clk),
    .reset(reset),
    .ultrasonic_sensor(ultrasonic_sensor),
    .car_count(car_count),
    .empty_space(empty_space),
    .lcd_data(lcd_data),
    .lcd_enable(lcd_enable),
    .lcd_rs(lcd_rs)
);

initial begin
    clk = 0;
    reset = 1;
    ultrasonic_sensor = 0;
    total_cars = 0;
    total_empty_spaces = 3; // Assuming 4 parking spaces initially
    #10 reset = 0;
end

always begin
    #5 clk = ~clk;
end

initial begin
    ultrasonic_sensor = 1;
    #20 ultrasonic_sensor = 0;
    total_cars = total_cars + 1;
    total_empty_spaces = total_empty_spaces - 1;
    $display("Car Parked : %s \t LCD : %dmins", "Yes", lcd_data);

    ultrasonic_sensor = 0;
    #20 ultrasonic_sensor = 0;
    $display("Car Parked : %s \t LCD : %s", ultrasonic_sensor ? "Yes" : "No", ultrasonic_sensor ? lcd_data : "-NA-");

    ultrasonic_sensor = 1;
    #20 ultrasonic_sensor = 0;
    total_cars = total_cars + 1;
    total_empty_spaces = total_empty_spaces - 1;
    $display("Car Parked : %s \t LCD : %dmins", "Yes", lcd_data);

    #10; // Delay to ensure all results are displayed
    $display("Total Cars : %d", total_cars);
    $display("Empty spaces: %d", total_empty_spaces);
    $finish;
end

endmodule
