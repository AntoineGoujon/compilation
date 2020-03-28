	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq $10, %rbx
	movq %rbx, %rdi
L17:
	movq $1, %rdi
	movq $1, %rcx
	movq %rbx, %rsi
	subq %rcx, %rsi
	movq %rsi, %rbx
	movq %rbx, %rcx
	addq %rdi, %rcx
	cmpq $0, %rcx
	jz L4
	movq %rbx, %rcx
	movq $65, %rdi
	addq %rcx, %rdi
	call putchar
	jmp L17
L4:
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
