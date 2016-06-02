/* For printf. */
#include <stdio.h>
/* For realpath. */
#include <stdlib.h>
/* For PATH_MAX (the maximum length of a path). */
#include <sys/param.h>
/* For strerror. */
#include <string.h>
/* For errno. */
#include <errno.h>

static int
read_realpath (char * argv0)
{
	char command[PATH_MAX];
    char resolved_path[PATH_MAX];

    if (realpath (argv0, resolved_path) == 0) {
	    fprintf (stderr, "realpath failed: %s\n", strerror (errno));
        return 1;
    } else {
        system ("mkdir %s-data\n", argv0);
    	sprintf (command, "%s %s %s-data\n", "./one", resolved_path, argv0);
    	printf (command);
    	system (command);
    }
}

long exe_size = 9176;

int
main (int argc, char ** argv)
{
    printf ("Program called as '%s'\n", argv[0]);
    return read_realpath (argv[0]);
}
