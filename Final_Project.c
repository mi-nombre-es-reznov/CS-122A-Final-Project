/*
 * CS_122A_Final_Project.c
 *
 * Created: 11/11/2018 10:27:03 AM
 * Author : xXSexybeastXx
 */ 

// Pre-processor files
#include <avr/io.h>
#include <util/delay.h>

// Variables
unsigned char seat_1, seat_2, seat_3, seat_4, seat_5, seat_6;
unsigned char belt_1, belt_2, belt_3, belt_4, belt_5, belt_6;

// Enumerated states
enum ID_States {ID_SMStart, ID_Init, ID_assign_values} ID_state;
enum SL_States {SL_Init, SL_Lights} SL_state;
		
// Call Functions
void input_detector()
{
	switch(ID_state)
	{
		case ID_SMStart:
		{
			ID_state = ID_Init;
			break;
		}
		case ID_Init:
		{
			ID_state = ID_assign_values;
			break;
		}
		case ID_assign_values:
		{
			if((~PINA & 0x01) == 0x01)
			{
				seat_1 = 1;
			}
			else
			{
				seat_1 = 0;
			}
			
			if((~PINA & 0x02) == 0x02)
			{
				seat_2 = 1;
			}
			else
			{
				seat_2 = 0;
			}
			
			if((~PINA & 0x04) == 0x04)
			{
				seat_3 = 1;
			}
			else
			{
				seat_3 = 0;
			}
			
			if((~PINA & 0x08) == 0x08)
			{
				seat_4 = 1;
			}
			else
			{
				seat_4 = 0;
			}
			
			if((~PINA & 0x10) == 0x10)
			{
				seat_5 = 1;
			}
			else
			{
				seat_5 = 0;
			}
			
			if((~PINA & 0x20) == 0x20)
			{
				seat_6 = 1;
			}
			else
			{
				seat_6 = 0;
			}			
			
			ID_state = ID_assign_values;
			break;
		}
		default:
			break;
	}
	
	switch(ID_state)
	{
		case ID_SMStart:
			break;
		case ID_Init:
		{
			seat_1 = 0;
			seat_2 = 0;
			seat_3 = 0;
			seat_4 = 0;
			seat_5 = 0;
			seat_6 = 0;
			belt_1 = 0;
			belt_2 = 0;
			belt_3 = 0;
			belt_4 = 0;
			belt_5 = 0;
			belt_6 = 0;
			
			break;
		}
		case ID_assign_values:
		{
			if((seat_1 == 1))
			{
				PORTB = 0x01;
			}
			else
			{
				PORTB = 0x00;
			}
			
			break;
		}
		default:
		{
			PORTB = 0xFF;
			break;
		}
	}
}

// Main
int main(void) {
	
	// initialize ports
	DDRB = 0xFF; PORTB = 0x00;
	DDRA = 0x00; PORTA = 0xFF;
	DDRC = 0x00; PORTC = 0xFF;

	while(1) 
	{
		input_detector();
		_delay_ms(500);
	}
}
