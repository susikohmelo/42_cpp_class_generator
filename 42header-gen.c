/* 

Poor man's 42 header generation
-------------------------------
by: susikohmelo aka. ljylhank


This program outputs a 42 header to stdout
which you can easily redirect to a file.

File-, username and email are taken as argument
*/

#include <unistd.h>
#include <stdio.h>
#include <string.h>
#include <time.h>

int print_time(void)
{
	int	chars_printed = 0;

	time_t t = time(NULL);
	struct tm tm = *localtime(&t);

	chars_printed += printf("%d/", tm.tm_year + 1900);
	fflush(stdout);

	if (tm.tm_mon + 1 < 10)
	{ write(1, "0", 1); ++chars_printed; }
	chars_printed += printf("%d/", tm.tm_mon + 1);
	fflush(stdout);

	if (tm.tm_mday < 10)
	{ write(1, "0", 1); ++chars_printed; }
	chars_printed += printf("%d ", tm.tm_mday);
	fflush(stdout);

	if (tm.tm_hour < 10)
	{ write(1, "0", 1); ++chars_printed; }
	chars_printed += printf("%d:", tm.tm_hour);
	fflush(stdout);

	if (tm.tm_min < 10)
	{ write(1, "0", 1); ++chars_printed; }
	chars_printed += printf("%d:", tm.tm_min);
	fflush(stdout);

	if (tm.tm_sec < 10)
	{ write(1, "0", 1); ++chars_printed; }
	chars_printed += printf("%d", tm.tm_sec);
	fflush(stdout);

	return (chars_printed);
}

int	main(int argc, char **argv)
{
	int		i = 0;
	int		i2 = 0;
	int		toprint = 0;
	char	*template = "/* ************************************************************************** */\n"
						"/*                                                                            */\n"
						"/*                                                        :::      ::::::::   */\n"
						"/*   F                                                  :+:      :+:    :+:   */\n"
						"/*                                                    +:+ +:+         +:+     */\n"
						"/*   B                                              +#+  +:+       +#+        */\n"
						"/*                                                +#+#+#+#+#+   +#+           */\n"
						"/*   C                                                 #+#    #+#             */\n"
						"/*   U                                                ###   ########.fr       */\n"
						"/*                                                                            */\n"
						"/* ************************************************************************** */\n";
	if (argc < 4)
	{
		printf("Too few arguments to generate 42header\n");
		return (1);
	}

	while (i < strlen(template))
	{
		if (template[i] == 'F')
		{
			i2 = 0; toprint = strlen(argv[1]);
			while (i2 < toprint)
			{ write(1, argv[1] + i2, 1); ++i; ++i2; }
		}
		else if (template[i] == 'B')
		{
			write(1, "By: ", 4); i += 4;

			i2 = 0; toprint = strlen(argv[2]);
			while (i2 < toprint)
			{ write(1, argv[2] + i2, 1); ++i; ++i2; }

			write(1, " <", 2); i += 2;

			i2 = 0; toprint = strlen(argv[3]);
			while (i2 < toprint)
			{ write(1, argv[3] + i2, 1); ++i; ++i2; }

			write(1, ">", 1); i += 1;
		}
		else if (template[i] == 'C')
		{
			write(1, "Created: ", 9); i += 9;
			i += print_time();
			write(1, " by ", 4); i += 4;

			i2 = 0; toprint = strlen(argv[2]); 
			while (i2 < toprint)
			{ write(1, argv[2] + i2, 1); ++i; ++i2; }
		}
		else if (template[i] == 'U')
		{
			write(1, "Updated: ", 9); i += 9;
			i += print_time();
			write(1, " by ", 4); i += 4;

			i2 = 0; toprint = strlen(argv[2]); 
			while (i2 < toprint)
			{ write(1, argv[2] + i2, 1); ++i; ++i2; }
		}
		else
		{ write(1, template + i, 1); ++i; }
	}
}
