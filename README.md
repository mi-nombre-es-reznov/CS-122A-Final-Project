<h1 align="center">
  Archived
</h1>

# CS-122A Final Project: Advanced Seatbelt Monitor for Tesla Vehicles

## Overview

For my CS 122A final project, I developed an advanced seatbelt monitoring system tailored for Tesla vehicles. This project was inspired by a tragic incident where a Tesla driver ignored safety warnings, leading to a fatal crash. My goal was to enhance vehicle safety and potentially save lives by creating a system that integrates seamlessly with Tesla’s existing technology.

## Problem Identification

The inspiration for this project stemmed from a real-world scenario where a Tesla driver disregarded multiple safety warnings from the vehicle's autopilot system. Despite numerous alerts, the driver failed to engage with the system, resulting in a catastrophic crash. Tesla’s subsequent updates aimed to address this by increasing warning frequencies and disabling autopilot after repeated violations.

## Solution Concept

Building on Tesla’s advancements, I designed a comprehensive seatbelt monitoring system that goes beyond current implementations. This system leverages the car's Bluetooth dashboard for communication between the seats and the driver, integrating weight sensors and real-time data processing to ensure safety.

## Key Features

1. **Integrated Bluetooth Communication**: Each seat is equipped with Bluetooth capabilities to communicate with the vehicle’s dashboard and computer system, providing real-time status updates.

2. **Dynamic Weight Sensors**: Weight sensors in each seat detect occupancy and ensure that seatbelts are engaged. If a seat with detected weight lacks a seatbelt, the vehicle will not start.

3. **Selective Disabling**: Drivers can disable the monitoring feature for non-critical seats (e.g., seats with objects that don’t need seatbelts) but cannot disable the monitoring for the driver’s seat. This ensures compliance with safety protocols, especially in conjunction with autopilot requirements.

4. **Safety Overrides**: The system prevents the car from shifting out of park unless all occupied seats with detected weight have their seatbelts fastened, enhancing overall safety.

5. **Auto-Disengagement**: In line with Tesla’s approach, the system can disable the car’s autopilot and come to a safe stop if repeated seatbelt violations occur, ensuring the vehicle is safely controlled.

## Impact

This seatbelt monitor addresses safety gaps by enforcing seatbelt use more rigorously, potentially reducing injuries and fatalities in the event of an accident. It complements Tesla’s existing safety features and provides an additional layer of protection for all passengers.

By integrating advanced monitoring with Tesla’s existing systems, this project represents a significant step forward in automotive safety technology.
