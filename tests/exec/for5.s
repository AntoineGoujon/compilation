	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq $10, %rdi
	movq %rdi, %rbx
	movq %rbx, %rdi
L16:
	movq %rbx, %rdi
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
	jmp L16
L4:
	movq $10, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
