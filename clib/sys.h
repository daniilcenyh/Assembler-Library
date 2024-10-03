#include <stdint.h>

extern uint64_t c_file_create(uint8_t * file_name, uint8_t permissions);
extern void c_file_delete(uint8_t * file_name);
extern uint64_t c_file_open(uint8_t * file_name, uint8_t mode);
extern void c_file_close(uint64_t descriptor);
extern void c_file_write(uint64_t descriptor, uint8_t * data, uint64_t size);
extern void c_file_read(uint64_t descriptor, uint8_t * buffer, uint64_t size);
extern void c_file_seek(uint64_t descriptor, uint8_t mode, uint64_t posittion);
extern void c_exit(void);