`timescale 1ns / 1ps 
module tb_parking_place;

    reg clk = 0;
    reg reset = 0;
    reg car_arrival = 0;
    reg car_depart = 0;

    wire [3:0] cars_parked;
    wire [3:0] spaces_left;
    wire parking_full;

    parking_place uut (
        .clk(clk),
        .reset(reset),
        .car_arrival(car_arrival),
        .car_depart(car_depart),
        .cars_parked(cars_parked),
        .spaces_left(spaces_left),
        .parking_full(parking_full)
    );

    always begin
        #5 clk = ~clk;
    end

    initial begin
        reset = 1;
        #10 reset = 0;
    end
    initial begin
        #100;
        $finish;
    end

    // Car arrival and departure 
    initial begin
        car_arrival = 1;
        #10 car_arrival = 0;
        #10 car_arrival = 1;
        #10 car_arrival = 1;
        #10 car_arrival = 1;
        #10 car_arrival = 1;
        #10 car_arrival = 0;
        #10 car_depart = 1;
        #10 car_depart = 0;
        #10 car_depart = 1;
        #10 car_depart = 0;
        #10 car_depart = 1;
        #10 car_depart = 0;
        #10 car_arrival = 1;
        #10 car_arrival = 0;
    end

    always begin
        $display("Time: %0t, Cars Parked: %d, Spaces Left: %d, Parking Full: %b", $time, cars_parked, spaces_left, parking_full);
        #5;
    end

endmodule
