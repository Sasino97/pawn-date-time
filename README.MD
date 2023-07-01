# DateTime Utility Library for the Pawn Language

## Warning
While the library has been thoroughly tested and did not produce any known issue, it is provided "as is" (see points 6 and 7 of the license), and this repository is no longer maintained.


## Introduction

This library provides useful functions to work with dates and times in Pawn. I've been using it for years now, together with other personal utility libraries, but today I decided to make this one available for use and open source.


## Description

The library was inspired by the .NET DateTime struct, however there are major differences. The most obvious difference is that Pawn is not an object oriented language, so all the functions would be considered static methods in a static class. Another important difference is that the information for one DateTime instance is stored in a 64-bit integer in .NET, while in this case I decided to store the value in an array of 6 (32-bit) cells for simplicity (year, month, day, hour, minute, second), making each DateTime 192 bits in length. There are currently no functions to work with week days, nor functions to parse/print extended dates (with week day names or month names). The only calendar supported is the Gregorian (western) calendar.

  

## Formats

In memory, DateTimes are all stored in the "YMDhms" format, and all the functions expect this format, however, the library provides a way to parse and output strings in the major formats, separated by any 1-character separator.

### The supported date formats are:
```pawn
enum DateFormat
{
	DateFormat.BigEndian,    // Year, Month, Day
	DateFormat.LittleEndian, // Day, Month, Year
	DateFormat.MiddleEndian  // Month, Day, Year
}
```
  
### The supported time formats are:
```pawn
enum TimeFormat
{
	TimeFormat.H24, // 24 hours (0-23)
	TimeFormat.H12  // 12 hours (1-12) + AM/PM
}
```

## Functions

Complete list of functions:
```pawn
DateTime: DateTime.New(cell: year = 0, cell: month = 1, cell: day = 1, cell: hour = 0, cell: minute = 0, cell: second = 0);
DateTime: DateTime.NewDate(cell: year = 0, cell: month = 1, cell: day = 1);
DateTime: DateTime.NewTime(cell: hour = 0, cell: minute = 0, cell: second = 0);
DateTime: DateTime.Clone(const DateTime: other[DateTime.Size]);
DateTime: DateTime.Now();
DateTime: DateTime.Today();
DateTime: DateTime.CurrentTime();
cell: DateTime.GetYear(const DateTime: dateTime[DateTime.Size]);
void: DateTime.SetYear(DateTime: dateTime[DateTime.Size], cell: year);
cell: DateTime.GetMonth(const DateTime: dateTime[DateTime.Size]);
void: DateTime.SetMonth(DateTime: dateTime[DateTime.Size], cell: month);
cell: DateTime.GetDay(const DateTime: dateTime[DateTime.Size]);
void: DateTime.SetDay(DateTime: dateTime[DateTime.Size], cell: day);
cell: DateTime.GetHour(const DateTime: dateTime[DateTime.Size]);
void: DateTime.SetHour(DateTime: dateTime[DateTime.Size], cell: hour);
cell: DateTime.GetMinute(const DateTime: dateTime[DateTime.Size]);
void: DateTime.SetMinute(DateTime: dateTime[DateTime.Size], cell: minute);
cell: DateTime.GetSecond(const DateTime: dateTime[DateTime.Size]);
void: DateTime.SetSecond(DateTime: dateTime[DateTime.Size], cell: second);
cell: DateTime.Compare(const DateTime: dateTime1[DateTime.Size], const DateTime: dateTime2[DateTime.Size]);
bool: DateTime.Equals(const DateTime: dateTime1[DateTime.Size], const DateTime: dateTime2[DateTime.Size]);
cell: DateTime.GetNumberOfDays(cell: year, cell: month = 0);
void: DateTime.AddYears(DateTime: dateTime[DateTime.Size], cell: years);
void: DateTime.AddMonths(DateTime: dateTime[DateTime.Size], cell: months);
void: DateTime.AddDays(DateTime: dateTime[DateTime.Size], cell: days);
void: DateTime.AddHours(DateTime: dateTime[DateTime.Size], cell: hours);
void: DateTime.AddMinutes(DateTime: dateTime[DateTime.Size], cell: minutes);
void: DateTime.AddSeconds(DateTime: dateTime[DateTime.Size], cell: seconds);
DateTime: DateTime.ParseDate(const cell: dateString[], DateFormat: dateFormat = DEFAULT_DATE_FORMAT, cell: dateSeparator = DEFAULT_DATE_SEPARATOR);
DateTime: DateTime.ParseTime(const cell: timeString[], TimeFormat: timeFormat = DEFAULT_TIME_FORMAT, cell: timeSeparator = DEFAULT_TIME_SEPARATOR);
DateTime: DateTime.Parse(const cell: dateTimeString[], DateFormat: dateFormat = DEFAULT_DATE_FORMAT, TimeFormat: timeFormat = DEFAULT_TIME_FORMAT, cell: dateSeparator = DEFAULT_DATE_SEPARATOR, cell: timeSeparator = DEFAULT_TIME_SEPARATOR);
cell: DateTime.ToDateString(const DateTime: dateTime[DateTime.Size], DateFormat: dateFormat = DEFAULT_DATE_FORMAT, cell: dateSeparator = DEFAULT_DATE_SEPARATOR);
cell: DateTime.ToTimeString(const DateTime: dateTime[DateTime.Size], TimeFormat: timeFormat = DEFAULT_TIME_FORMAT, cell: timeSeparator = DEFAULT_TIME_SEPARATOR);
cell: DateTime.ToString(const DateTime: dateTime[DateTime.Size], DateFormat: dateFormat = DEFAULT_DATE_FORMAT, TimeFormat: timeFormat = DEFAULT_TIME_FORMAT, cell: dateSeparator = DEFAULT_DATE_SEPARATOR, cell: timeSeparator = DEFAULT_TIME_SEPARATOR);
```
note: both cell and void are defined as _ (no tag)

  

## Example

As an example, here you are the test script (included in the package):
```pawn
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
```
Output:
```
New(), NewDate(), NewTime()
1997-03-29 23:18:12
1997-03-29 00:00:00
0000-01-01 23:18:12

Clone()
2010-05-12 06:22:12

Now(), Today(), CurrentTime()
2019-07-05 15:48:53
2019-07-05 00:00:00
0000-01-01 15:48:53

Getters and Setters
2017-08-12 12:50:45
2017
8
12
12
50
45
1956-06-03 15:22:12

Compare() and Equals()
2019-05-11 10:10:55 > 2017-08-12 12:50:45
2019-05-11 10:10:55 < 2022-05-01 12:02:06
2019-05-11 10:10:55 != 2022-05-01 12:02:06
2019-05-11 10:10:55 = 2019-05-11 10:10:55

GetNumberOfDays()
2017 has 365 days
2018 has 365 days
2019 has 365 days
2020 has 366 days
February 2017 has 28 days
February 2018 has 28 days
February 2019 has 28 days
February 2020 has 29 days

AddYears(), AddMonths(), AddDays(), AddHours(), AddMinutes(), AddSeconds()
2002-01-01 00:00:00
2007-11-22 11:23:20

Parse(), ParseDate(), ParseTime(), ToString(), ToDateString(), ToTimeString()
2019-05-02 22:50:10
2050-02-06
20:50:12

Parsing and producing strings with different/mixed formats and separators
05/24/2019 10:50:10 PM -> 24/05/2019 22:50:10
26-05-2005 11.15 AM -> 2005/05/26 11:15:00
2000/03/20 16:05:54 -> 03-20-2000 4.05.54 PM

Parse() benchmark
1000000 Parse() completed in 2144ms

ToString() benchmark
1000000 ToString() completed in 838ms
```

## License

Copyright (c) 2017-2021 Sasinosoft

The source code is subject to the terms of the [Mozilla Public License v2.0]([https://www.mozilla.org/en-US/MPL/2.0/](https://www.mozilla.org/en-US/MPL/2.0/)).
