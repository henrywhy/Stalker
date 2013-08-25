#include "include/paint.h"

void delay();

void isrc()
{
	int x, y;
	
	paintA(50, 50);
	
	delay();
	//先铺上背景
	for(x=0; x<=319; x++)
	{
		for(y=0; y<=199; y++)
		{			
			setPixel(x, y, 2);
		}
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