/*
 * Our own header, to be included before all standard system headers.
 */
#ifndef_APUE_H
#define_APUE_H

#define _POSIX_C_SOURCE 200809L

#if defined(SOLARIS)/* Solaris 10 */
#define _XOPEN_SOURCE 600
#else
#define _XOPEN_SOURCE 700
#endif

#include <sys/types.h>/* some systems still require this */
#include <sys/stat.h>
#include <sys/termios.h>/* for winsize */
#if defined(MACOS) || !defined(TIOCGWINSZ)
#include <sys/ioctl.h>
#endif

#include <stdio.h>/* for convenience */
#include <stdlib.h>/* for convenience */
#include <stddef.h>/* for offsetof */
#include <string.h>/* for convenience */
#include <unistd.h>/* for convenience */
#include <signal.h>/* for SIG_ERR */

#defineMAXLINE4096/* max line length */

/*
 * Default file access permissions for new files.
 */
#defineFILE_MODE(S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH)

/*
 * Default permissions for new directories.
 */
#defineDIR_MODE(FILE_MODE | S_IXUSR | S_IXGRP | S_IXOTH)

typedefvoidSigfunc(int);/* for signal handlers */

#definemin(a,b)((a) < (b) ? (a) : (b))
#definemax(a,b)((a) > (b) ? (a) : (b))

/*
 * Prototypes for our own functions.
 */
char*path_alloc(size_t *);/* {Prog pathalloc} */
long open_max(void);/* {Prog openmax} */

int set_cloexec(int);/* {Prog setfd} */
void clr_fl(int, int);
void set_fl(int, int);/* {Prog setfl} */

void pr_exit(int);/* {Prog prexit} */

void pr_mask(const char *);/* {Prog prmask} */
Sigfunc*signal_intr(int, Sigfunc *);/* {Prog signal_intr_function} */

void daemonize(const char *);/* {Prog daemoninit} */

void sleep_us(unsigned int);/* {Ex sleepus} */
ssize_t readn(int, void *, size_t);/* {Prog readn_writen} */
ssize_t writen(int, const void *, size_t);/* {Prog readn_writen} */

int fd_pipe(int *);/* {Prog sock_fdpipe} */
int recv_fd(int, ssize_t (*func)(int,
                                 const void *, size_t));/* {Prog recvfd_sockets} */
int send_fd(int, int);/* {Prog sendfd_sockets} */
int send_err(int, int,
             const char *);/* {Prog senderr} */
int serv_listen(const char *);/* {Prog servlisten_sockets} */
int serv_accept(int, uid_t *);/* {Prog servaccept_sockets} */
int cli_conn(const char *);/* {Prog cliconn_sockets} */
int buf_args(char *, int (*func)(int,
                                 char **));/* {Prog bufargs} */

int tty_cbreak(int);/* {Prog raw} */
int tty_raw(int);/* {Prog raw} */
int tty_reset(int);/* {Prog raw} */
void tty_atexit(void);/* {Prog raw} */
struct termios*tty_termios(void);/* {Prog raw} */

int ptym_open(char *, int);/* {Prog ptyopen} */
int ptys_open(char *);/* {Prog ptyopen} */
#ifdefTIOCGWINSZ
pid_t pty_fork(int *, char *, int, const struct termios *,
               const struct winsize *);/* {Prog ptyfork} */
#endif

intlock_reg(int, int, int, off_t, int, off_t); /* {Prog lockreg} */

#defineread_lock(fd, offset, whence, len)                       \
    lock_reg((fd), F_SETLK, F_RDLCK, (offset), (whence), (len))
#definereadw_lock(fd, offset, whence, len)                      \
    lock_reg((fd), F_SETLKW, F_RDLCK, (offset), (whence), (len))
#definewrite_lock(fd, offset, whence, len)                      \
    lock_reg((fd), F_SETLK, F_WRLCK, (offset), (whence), (len))
#definewritew_lock(fd, offset, whence, len)                     \
    lock_reg((fd), F_SETLKW, F_WRLCK, (offset), (whence), (len))
#defineun_lock(fd, offset, whence, len)                         \
    lock_reg((fd), F_SETLK, F_UNLCK, (offset), (whence), (len))

pid_tlock_test(int, int, off_t, int, off_t);/* {Prog locktest} */

#defineis_read_lockable(fd, offset, whence, len)                \
    (lock_test((fd), F_RDLCK, (offset), (whence), (len)) == 0)
#defineis_write_lockable(fd, offset, whence, len)               \
    (lock_test((fd), F_WRLCK, (offset), (whence), (len)) == 0)

voiderr_msg(const char *, ...);/* {App misc_source} */
voiderr_dump(const char *, ...) __attribute__((noreturn));
voiderr_quit(const char *, ...) __attribute__((noreturn));
voiderr_cont(int, const char *, ...);
voiderr_exit(int, const char *, ...) __attribute__((noreturn));
voiderr_ret(const char *, ...);
voiderr_sys(const char *, ...) __attribute__((noreturn));

voidlog_msg(const char *, ...);/* {App misc_source} */
voidlog_open(const char *, int, int);
voidlog_quit(const char *, ...) __attribute__((noreturn));
voidlog_ret(const char *, ...);
voidlog_sys(const char *, ...) __attribute__((noreturn));
voidlog_exit(int, const char *, ...) __attribute__((noreturn));

voidTELL_WAIT(void);/* parent/child from {Sec race_conditions} */
voidTELL_PARENT(pid_t);
voidTELL_CHILD(pid_t);
voidWAIT_PARENT(void);
voidWAIT_CHILD(void);

#endif/* _APUE_H */
