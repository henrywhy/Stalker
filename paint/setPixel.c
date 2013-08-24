//在像素上画指定的颜色
void setPixel(int x, int y, int color)
{
	char * p;
	int i = x + y*320;
	p = (char *)i;
	*p = color;
}