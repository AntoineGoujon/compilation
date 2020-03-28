	.text
	.globl main
print_row:
	pushq %rbp
	movq %rsp, %rbp
	addq $-32, %rsp
	movq %rbx, -32(%rbp)
	movq %rsi, -8(%rbp)
	movq %rdi, -16(%rbp)
	movq $0, %rbx
	movq %rbx, %rdi
L23:
	movq -8(%rbp), %rdi
	movq %rbx, -24(%rbp)
	cmpq %rdi, -24(%rbp)
	jle L20
	movq $10, %rdi
	call putchar
	movq $0, %rax
	movq -32(%rbp), %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
L20:
	movq $0, -24(%rbp)
	movq %rbx, %rsi
	movq -16(%rbp), %rdi
	call get
	cmpq -24(%rbp), %rax
	setne %al
	movzbq %al, %rax
	cmpq $0, %rax
	jz L14
	movq $42, %rax
	movq %rax, %rdi
	call putchar
L10:
	movq $1, %rax
	movq %rbx, %rdi
	addq %rax, %rdi
	movq %rdi, %rbx
	movq %rbx, %rdi
	jmp L23
L14:
	movq $46, %rdi
	call putchar
	jmp L10
set:
	pushq %rbp
	movq %rsp, %rbp
	movq $0, %rax
	movq %rsi, %rcx
	cmpq %rax, %rcx
	sete %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L34
	movq %rdx, %rcx
	movq %rcx, 0(%rdi)
L27:
	movq %rcx, %rax
	popq %rbp
	ret
L34:
	movq $1, %rax
	movq %rsi, %rcx
	subq %rax, %rcx
	movq 8(%rdi), %rdi
	movq %rcx, %rsi
	call set
	movq %rax, %rcx
	jmp L27
compute_row:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq %rdi, -24(%rbp)
	movq %rsi, %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rcx
L71:
	movq $0, %rcx
	movq -8(%rbp), %rdi
	cmpq %rcx, %rdi
	setg %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L48
	movq $1, %rdi
	movq -8(%rbp), %rcx
	subq %rdi, %rcx
	movq -24(%rbp), %rdi
	movq %rcx, %rsi
	call get
	movq %rax, -16(%rbp)
	movq -8(%rbp), %rcx
	movq -24(%rbp), %rdi
	movq %rcx, %rsi
	call get
	addq -16(%rbp), %rax
	movq %rax, %rdi
	call mod7
	movq %rax, %rcx
	movq -8(%rbp), %rsi
	movq -24(%rbp), %rdi
	movq %rcx, %rdx
	call set
	movq $1, %rax
	movq -8(%rbp), %rdi
	subq %rax, %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rdx
	jmp L71
L48:
	movq $1, %rdx
	movq $0, %rsi
	movq -24(%rbp), %rdi
	call set
	movq $0, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
mod7:
	pushq %rbp
	movq %rsp, %rbp
	movq $7, %rcx
	movq %rdi, %rax
	cqto
	idivq %rcx
	movq $7, %rcx
	imulq %rax, %rcx
	subq %rcx, %rdi
	movq %rdi, %rax
	popq %rbp
	ret
get:
	pushq %rbp
	movq %rsp, %rbp
	movq $0, %rdx
	movq %rsi, %rcx
	cmpq %rdx, %rcx
	sete %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L89
	movq 0(%rdi), %rax
L83:
	popq %rbp
	ret
L89:
	movq $1, %rcx
	subq %rcx, %rsi
	movq 8(%rdi), %rdi
	call get
	jmp L83
pascal:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq %rdi, -24(%rbp)
	movq $1, %rcx
	movq -24(%rbp), %rdi
	addq %rcx, %rdi
	call create
	movq %rax, -8(%rbp)
	movq -8(%rbp), %r15
	movq %r15, -16(%rbp)
	movq $0, -16(%rbp)
	movq -16(%rbp), %rdi
L116:
	movq -24(%rbp), %rdi
	movq -16(%rbp), %rdx
	cmpq %rdi, %rdx
	jl L113
	movq $0, -16(%rbp)
	movq -16(%rbp), %rax
	movq %rbp, %rsp
	popq %rbp
	ret
L113:
	movq $0, %rdx
	movq -16(%rbp), %rsi
	movq -8(%rbp), %rdi
	call set
	movq %rax, %rsi
	movq -16(%rbp), %rsi
	movq -8(%rbp), %rdi
	call compute_row
	movq %rax, %rcx
	movq -16(%rbp), %rcx
	movq -8(%rbp), %rdi
	movq %rcx, %rsi
	call print_row
	movq %rax, %rdi
	movq $1, %rdi
	movq -16(%rbp), %rcx
	addq %rdi, %rcx
	movq %rcx, -16(%rbp)
	jmp L116
create:
	pushq %rbp
	movq %rsp, %rbp
	addq $-16, %rsp
	movq %rdi, -16(%rbp)
	movq $0, %rdi
	movq -16(%rbp), %rcx
	cmpq %rdi, %rcx
	sete %cl
	movzbq %cl, %rcx
	cmpq $0, %rcx
	jz L142
	movq $0, %rax
L126:
	movq %rbp, %rsp
	popq %rbp
	ret
L142:
	movq $16, %rdi
	call sbrk
	movq %rax, %rdi
	movq %rdi, -8(%rbp)
	movq -8(%rbp), %rdi
	movq $0, %rdi
	movq -8(%rbp), %rcx
	movq %rdi, 0(%rcx)
	movq $1, %rdi
	movq -16(%rbp), %rcx
	subq %rdi, %rcx
	movq %rcx, %rdi
	call create
	movq -8(%rbp), %rdi
	movq %rax, 8(%rdi)
	movq -8(%rbp), %rax
	jmp L126
main:
	pushq %rbp
	movq %rsp, %rbp
	movq $42, %rdi
	call pascal
	movq $0, %rax
	popq %rbp
	ret
	.data
