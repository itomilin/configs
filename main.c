// https://stackoverflow.com/questions/13351172/inotify-file-in-c
// http://rus-linux.net/MyLDP/algol/getting-started-with-inotify.html
#include <stdlib.h>
#include <stdio.h>
#include <errno.h>
#include <time.h>
#include <sys/stat.h>

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/inotify.h>
#include <unistd.h>

#include <linux/netlink.h>
#include <linux/genetlink.h>

#define EVENT_SIZE  (sizeof(struct inotify_event))
#define BUF_LEN     (1024 * (EVENT_SIZE + 16))

//int file_is_modified(const char *path, time_t oldMTime) {
//int file_is_modified(const char *path) {
//    struct stat file_stat;
//    int err = stat(path, &file_stat);
//    if (err != 0) {
//        perror(" [file_is_modified] stat");
//        exit(errno);
//    }
//    printf("%s", "ololol");
//    return file_stat.st_mtime;
//}
//
//int main() {
//    int length, i = 0;
//    int fd;
//    int wd;
//    char buffer[BUF_LEN];
//    fd = inotify_init();
//
//    if (fd < 0) {
//        perror("inotify_init");
//    }
//
//    while( 1 ) {
//    	//wd = inotify_add_watch(fd, "/root/ll", IN_MODIFY );
//    	wd = inotify_add_watch(fd, "/sys/class/power_supply/BAT0/energy_now", IN_MODIFY );
//    	length = read(fd, buffer, BUF_LEN);
//
//        struct inotify_event *event = (struct inotify_event *) &buffer[i];
//
//	if (event->mask & IN_MODIFY) {
//            printf("The file %s was modified.\n", event->name);
//        }
//    }
//    inotify_rm_watch( fd, wd );
//    close( fd );
//    return 0;
//}
#include <stdio.h>
#include <sys/inotify.h>
#include <unistd.h>

#define BAT_PATH "/sys/class/power_supply/BAT0"

int main(void)
{
    struct inotify_event ev = {0};
    int wd, ret = 1;
    ssize_t len;
    const int fd = inotify_init1(IN_CLOEXEC);
    if (fd < 0) {
        perror("inotify_init() failed");
        return ret;
    }
    /* else */
    wd = inotify_add_watch(fd, BAT_PATH "/energy_now", IN_ACCESS);
    if (wd < 0)
        goto end;
    /* else */
    len = read(fd, &ev, sizeof(ev));
    /* Again... never gets here. */
    if (len > 0 && (ev.mask & IN_ACCESS))
        puts("It worked!");
    inotify_rm_watch(fd, wd);
    ret = 0;
end:
    close(fd);
    return ret;
}
