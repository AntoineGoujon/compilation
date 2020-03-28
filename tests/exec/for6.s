	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq $10, %rbx
	movq %rbx, %rcx
L22:
	movq $1, %rcx
	movq $1, %rdi
	subq %rdi, %rbx
	movq %rbx, %rdi
	addq %rcx, %rdi
	cmpq $0, %rdi
	jz L4
	movq %rbx, %rcx
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	movq $1, %rax
	movq %rbx, %rdi
	subq %rax, %rdi
	movq %rdi, %rbx
	movq %rbx, %rdi
	jmp L22
L4:
	movq $10, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
