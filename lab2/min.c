extern	int	MIN_2(int	x,	int	y);
int	 main()	{
	int	a[5] = {1, 2, 3, 4, 5};
	int c = a[0];
	int i = 0;
	for (;i < 5;i++){
		c =	MIN_2(a[i], c);
	}
	return c;
}
