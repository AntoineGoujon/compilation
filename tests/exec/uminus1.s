	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $1, %rdi
	movq $0, %rcx
	subq %rdi, %rcx
	movq $66, %rdi
	addq %rcx, %rdi
	call putchar
	movq %rax, %rcx
	movq $1, %rcx
	movq $0, %rdi
	subq %rcx, %rdi
	movq $0, %rcx
	subq %rdi, %rcx
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	popq %rbp
	ret
	.data
