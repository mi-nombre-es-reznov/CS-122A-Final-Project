/*
 * User_Input.c
 *
 * Created: 11/11/2018 10:27:03 AM
 * Author : xXSexybeastXx
 */ 

// Pre-processor files
#include "User_input.h"

// Variables
unsigned char seat_1, seat_2, seat_3, seat_4, seat_5, seat_6;
unsigned char belt_1, belt_2, belt_3, belt_4, belt_5, belt_6;
unsigned int finish, flash_flag = 0;

// Enumerated states
enum ID_States {ID_SMStart, ID_Init, ID_assign_values} ID_state;
enum SL_States {SL_Init, SL_Lights} SL_state;
		/*
// Call Functions
void transmit_data(unsigned char data) {
	int i;
	for (i = 0; i < 8 ; ++i) {
		// Sets SRCLR to 1 allowing data to be set
		// Also clears SRCLK in preparation of sending data
		PORTC = 0x08;
		// set SER = next bit of data to be sent.
		PORTC |= ((data >> i) & 0x01);
		// set SRCLK = 1. Rising edge shifts next bit of data into the shift register
		PORTC |= 0x02;
	}
	// set RCLK = 1. Rising edge copies data from “Shift” register to “Storage” register
	PORTC |= 0x04;
	// clears all lines in preparation of a new transmission
	PORTC = 0x00;
}*/

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
			
			if((~PINC & 0x01) == 0x01)
			{
				belt_1 = 1;
			}
			else
			{
				belt_1 = 0;
			}
			
			if((~PINC & 0x02) == 0x02)
			{
				belt_2 = 1;
			}
			else
			{
				belt_2 = 0;
			}
			
			if((~PINC & 0x04) == 0x04)
			{
				belt_3 = 1;
			}
			else
			{
				belt_3 = 0;
			}
			
			if((~PINC & 0x08) == 0x08)
			{
				belt_4 = 1;
			}
			else
			{
				belt_4 = 0;
			}
			
			if((~PINC & 0x10) == 0x10)
			{
				belt_5 = 1;
			}
			else
			{
				belt_5 = 0;
			}
			
			if((~PINC & 0x20) == 0x20)
			{
				belt_6 = 1;
			}
			else
			{
				belt_6 = 0;
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
			if((seat_1 == 1) && (belt_1 == 1))
			{
				PORTB |= 0x01;
			}
			else
			{
				PORTB &= 0xFE;
				
				if((seat_1 == 1) && (belt_1 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}
			}
			
			if((seat_2 == 1) && (belt_2 == 1))
			{
				PORTB |= 0x02;
			}
			else
			{
				PORTB &= 0xFD;
				
				if((seat_2 == 1) && (belt_2 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}
			}	
			
			if((seat_3 == 1) && (belt_3 == 1))
			{
				PORTB |= 0x04;
			}
			else
			{
				PORTB &= 0xFB;
				
				if((seat_3 == 1) && (belt_3 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}
			}
			
			if((seat_4 == 1) && (belt_4 == 1))
			{
				PORTB |= 0x08;
			}
			else
			{
				PORTB &= 0xF7;
				
				if((seat_4 == 1) && (belt_4 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}
			}
			
			if((seat_5 == 1) && (belt_5 == 1))
			{
				PORTB |= 0x10;
			}
			else
			{
				PORTB &= 0xEF;
				
				if((seat_5 == 1) && (belt_5 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}
			}
			
			if((seat_6 == 1) && (belt_6 == 1))
			{
				PORTB |= 0x20;
			}
			else
			{
				PORTB &= 0xDF;
				
				if((seat_6 == 1) && (belt_6 == 0))
				{
					PORTB |= 0xC0;
					_delay_ms(300);
					PORTB &= 0x3F;
					_delay_ms(300);
				}
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