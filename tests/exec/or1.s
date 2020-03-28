	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $1, %rdi
	cmpq $0, %rdi
	jz L38
L36:
	movq $1, %rcx
L34:
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $0, %rax
	cmpq $0, %rax
	jz L29
L27:
	movq $1, %rcx
L25:
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $1, %rax
	cmpq $0, %rax
	jz L20
L18:
	movq $1, %rcx
L16:
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $0, %rax
	cmpq $0, %rax
	jz L11
L9:
	movq $1, %rcx
L7:
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
L11:
	movq $0, %rdi
	cmpq $0, %rdi
	jnz L9
	movq $0, %rcx
	jmp L7
	jmp L9
L20:
	movq $0, %rdi
	cmpq $0, %rdi
	jnz L18
	movq $0, %rcx
	jmp L16
	jmp L18
L29:
	movq $2, %rdi
	cmpq $0, %rdi
	jnz L27
	movq $0, %rcx
	jmp L25
	jmp L27
L38:
	movq $1, %rdi
	cmpq $0, %rdi
	jnz L36
	movq $0, %rcx
	jmp L34
	jmp L36
	.data
