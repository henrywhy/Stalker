#include "include/paint.h"

 void delay();

void isrc(int scanCode)
{
	int x, y;

	paintNothing(50, 50);
	if(scanCode==0x1e || scanCode==0x9e)
	{
		paintA(50, 50);
	} else if(scanCode==0x12 || scanCode==0x92)
	{
		paintE(50, 50);
	} 
}

void delay()
{
	int i, j;
	for(i=0, j=0; i<100000; i++)
	{
		for(j=0; j<1000; j++)
		{
		
		}
	}
}