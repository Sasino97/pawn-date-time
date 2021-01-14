/*
 * Sasinosoft Utils
 * Copyright (c) 2017-2021 - Sasinosoft
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/. 
 */

#include <a_samp>
#include <sscanf2>
#include "../src/DateTime.inc"

main()
{
	//
	new DateTime: dt[DateTime.Size];
	new DateTime: dt2[DateTime.Size];

	// 
	printf("New(), NewDate(), NewTime()");

	dt = DateTime.New(1997, 3, 29, 23, 18, 12);
	printf(DateTime.ToString(dt));

	dt = DateTime.NewDate(1997, 3, 29);
	printf(DateTime.ToString(dt));

	dt = DateTime.NewTime(23, 18, 12);
	printf(DateTime.ToString(dt));

	//
	printf("\nClone()");

	dt = DateTime.Clone(DateTime.New(2010, 5, 12, 6, 22, 12));
	printf(DateTime.ToString(dt));

	// 
	printf("\nNow(), Today(), CurrentTime()");

	dt = DateTime.Now(); 
	printf(DateTime.ToString(dt));

	dt = DateTime.Today(); 
	printf(DateTime.ToString(dt));

	dt = DateTime.CurrentTime(); 
	printf(DateTime.ToString(dt));

	//
	printf("\nGetters and Setters");

	dt = DateTime.New(2017, 8, 12, 12, 50, 45);
	printf(DateTime.ToString(dt));

	printf("%d", DateTime.GetYear(dt));
	printf("%d", DateTime.GetMonth(dt));
	printf("%d", DateTime.GetDay(dt));
	printf("%d", DateTime.GetHour(dt));
	printf("%d", DateTime.GetMinute(dt));
	printf("%d", DateTime.GetSecond(dt));

	DateTime.SetYear(dt, 1956);
	DateTime.SetMonth(dt, 6);
	DateTime.SetDay(dt, 3);
	DateTime.SetHour(dt, 15);
	DateTime.SetMinute(dt, 22);
	DateTime.SetSecond(dt, 12);
	printf(DateTime.ToString(dt));

	//
	printf("\nCompare() and Equals()");

	dt = DateTime.New(2019, 5, 11, 10, 10, 55);
	dt2 = DateTime.New(2017, 8, 12, 12, 50, 45);

	new cell: comparisonResult = DateTime.Compare(dt, dt2);

	if (comparisonResult == 0)
		printf("%s = %s", DateTime.ToString(dt), DateTime.ToString(dt2));

	else if (comparisonResult < 0)
		printf("%s < %s", DateTime.ToString(dt), DateTime.ToString(dt2));

	else if (comparisonResult > 0)
		printf("%s > %s", DateTime.ToString(dt), DateTime.ToString(dt2));
		
	dt2 = DateTime.New(2022, 5, 1, 12, 2, 6);
	comparisonResult = DateTime.Compare(dt, dt2);

	if (comparisonResult == 0)
		printf("%s = %s", DateTime.ToString(dt), DateTime.ToString(dt2));

	else if (comparisonResult < 0)
		printf("%s < %s", DateTime.ToString(dt), DateTime.ToString(dt2));

	else if (comparisonResult > 0)
		printf("%s > %s", DateTime.ToString(dt), DateTime.ToString(dt2));

	if (DateTime.Equals(dt, dt2))
		printf("%s = %s", DateTime.ToString(dt), DateTime.ToString(dt2));
	else
		printf("%s != %s", DateTime.ToString(dt), DateTime.ToString(dt2));

	dt2 = DateTime.New(2019, 5, 11, 10, 10, 55);

	if (DateTime.Equals(dt, dt2))
		printf("%s = %s", DateTime.ToString(dt), DateTime.ToString(dt2));
	else
		printf("%s != %s", DateTime.ToString(dt), DateTime.ToString(dt2));

	//
	printf("\nGetNumberOfDays()");

	printf("2017 has %d days", DateTime.GetNumberOfDays(2017));
	printf("2018 has %d days", DateTime.GetNumberOfDays(2018));
	printf("2019 has %d days", DateTime.GetNumberOfDays(2019));
	printf("2020 has %d days", DateTime.GetNumberOfDays(2020));

	printf("February 2017 has %d days", DateTime.GetNumberOfDays(2017, 2));
	printf("February 2018 has %d days", DateTime.GetNumberOfDays(2018, 2));
	printf("February 2019 has %d days", DateTime.GetNumberOfDays(2019, 2));
	printf("February 2020 has %d days", DateTime.GetNumberOfDays(2020, 2));
	
	//
	printf("\nAddYears(), AddMonths(), AddDays(), AddHours(), AddMinutes(), AddSeconds()");
	
	dt = DateTime.New(2002, 1, 1, 0, 0, 0);
	printf(DateTime.ToString(dt));

	DateTime.AddYears(dt, 5);
	DateTime.AddMonths(dt, 4);
	DateTime.AddDays(dt, 200);
	DateTime.AddHours(dt, 120);
	DateTime.AddMinutes(dt, 600);
	DateTime.AddSeconds(dt, 5000);

	printf(DateTime.ToString(dt));
	// Check with https://www.timeanddate.com/date/timeadd.html to confirm

	//
	printf("\nParse(), ParseDate(), ParseTime(), ToString(), ToDateString(), ToTimeString()");
	
	dt = DateTime.Parse("2019-05-02 22:50:10");
	printf(DateTime.ToString(dt));

	dt = DateTime.ParseDate("2050-02-06");
	printf(DateTime.ToDateString(dt));

	dt = DateTime.ParseTime("20:50:12");
	printf(DateTime.ToTimeString(dt));

	//
	printf("\nParsing and producing strings with different/mixed formats and separators");

	dt = DateTime.Parse("05/24/2019 10:50:10 PM", DateFormat.MiddleEndian, TimeFormat.H12, '/', ':');
	printf("05/24/2019 10:50:10 PM -> %s", DateTime.ToString(dt, DateFormat.LittleEndian, TimeFormat.H24, '/', ':'));

	dt = DateTime.Parse("26-05-2005 11.15 AM", DateFormat.LittleEndian, TimeFormat.H12, '-', '.');
	printf("26-05-2005 11.15 AM -> %s", DateTime.ToString(dt, DateFormat.BigEndian, TimeFormat.H24, '/', ':'));

	dt = DateTime.Parse("2000/03/20 16:05:54", DateFormat.BigEndian, TimeFormat.H24, '/', ':');
	printf("2000/03/20 16:05:54 -> %s", DateTime.ToString(dt, DateFormat.MiddleEndian, TimeFormat.H12, '-', '.'));

	//
	printf("\nParse() benchmark");

	new cell: t = GetTickCount();
	for (new cell: i = 0; i < 1000000; i ++)
	{
		DateTime.Parse("2000/03/20 16:05:54", DateFormat.BigEndian, TimeFormat.H24, '/', ':');
	}
	printf("1000000 Parse() completed in %dms", GetTickCount() - t);

	//
	printf("\nToString() benchmark");

	t = GetTickCount();
	for (new cell: i = 0; i < 1000000; i ++)
	{
		DateTime.ToString(dt);
	}
	printf("1000000 ToString() completed in %dms", GetTickCount() - t);
}
