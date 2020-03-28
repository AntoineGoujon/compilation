	.text
	.globl main
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $-8, %rsp
	movq %rbx, -8(%rbp)
	movq $65, %rbx
	movq %rbx, %rdi
	movq %rbx, %rdi
	call putchar
	movq $1, %rax
	cmpq $0, %rax
	jz L16
	movq $66, %rax
	movq %rax, %rdi
	call putchar
L6:
	movq %rbx, %rax
	movq %rax, %rdi
	call putchar
	movq $10, %rax
	movq %rax, %rdi
	call putchar
	movq $0, %rax
	movq -8(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
L16:
	movq $67, %rdi
	call putchar
	jmp L6
	.data
