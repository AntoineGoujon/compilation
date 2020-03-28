	.text
	.globl main
add:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rdx
	movq %rsi, %rcx
	movq %rdi, %rsi
	movq %rcx, %rdi
	movq %rsi, %rcx
	addq %rdi, %rcx
	movq %rcx, %rax
	movq %rdx, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
div:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %r8
	movq %rsi, %rcx
	movq $8192, %rsi
	imulq %rsi, %rdi
	movq %rdi, %rsi
	movq %rsi, %r12
	movq %rcx, %r12
	movq $2, %r9
	movq %rcx, %rdi
	movq %rdi, %rax
	cqto
	idivq %r9
	movq %rax, %rdi
	movq %rsi, %rcx
	addq %rdi, %rcx
	movq %rcx, %rax
	cqto
	idivq %r12
	movq %rax, %rcx
	movq %rcx, %rax
	movq %r8, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
sub:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rdx
	movq %rbx, %rcx
	subq %rsi, %rdi
	movq %rdi, %rax
	movq %rdx, %r12
	movq %rcx, %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
of_int:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %rsi
	movq %rbx, %rcx
	movq $8192, %rbx
	imulq %rbx, %rdi
	movq %rdi, %rax
	movq %rsi, %r12
	movq %rcx, %rbx
	movq %rbp, %rsp
	popq %rbp
	ret
mul:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq %r12, %r8
	movq %rsi, %rcx
	imulq %rcx, %rdi
	movq %rdi, %rsi
	movq $8192, %rsi
	movq $2, %r9
	movq $8192, %rcx
	movq %rcx, %rax
	cqto
	idivq %r9
	movq %rax, %rcx
	addq %rcx, %rdi
	movq %rdi, %rax
	cqto
	idivq %rsi
	movq %rax, %rdi
	movq %rdi, %rax
	movq %r8, %r12
	movq %rbp, %rsp
	popq %rbp
	ret
iter:
	pushq %rbp
	movq %rsp, %rbp
	addq $-96, %rsp
	movq %r8, -56(%rbp)
	movq %rcx, -48(%rbp)
	movq %rdx, -32(%rbp)
	movq %rsi, -24(%rbp)
	movq %rdi, -8(%rbp)
	movq $100, %rcx
	movq -8(%rbp), %rdi
	cmpq %rcx, %rdi
	sete %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L76
	movq $1, %rdi
L39:
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
L76:
	movq -48(%rbp), %rcx
	movq -48(%rbp), %rdi
	movq %rcx, %rsi
	call mul
	movq %rax, %rdi
	movq %rdi, -72(%rbp)
	movq -72(%rbp), %rcx
	movq -56(%rbp), %rcx
	movq -56(%rbp), %rdi
	movq %rcx, %rsi
	call mul
	movq %rax, %rdi
	movq %rdi, -64(%rbp)
	movq -64(%rbp), %rdi
	movq $4, %rdi
	call of_int
	movq %rax, -40(%rbp)
	movq -64(%rbp), %rcx
	movq -72(%rbp), %rdi
	movq %rcx, %rsi
	call add
	movq %rax, %rdi
	cmpq -40(%rbp), %rdi
	setg %dil
	movzbq %dil, %rdi
	cmpq $0, %rdi
	jz L58
	movq $0, %rdi
	jmp L39
L58:
	movq -32(%rbp), %r15
	movq %r15, -16(%rbp)
	movq -56(%rbp), %rcx
	movq -48(%rbp), %rdi
	movq %rcx, %rsi
	call mul
	movq %rax, -96(%rbp)
	movq $2, %rdi
	call of_int
	movq %rax, %rdi
	movq -96(%rbp), %rsi
	call mul
	movq %rax, %rdi
	movq -16(%rbp), %rsi
	call add
	movq %rax, -88(%rbp)
	movq -24(%rbp), %r15
	movq %r15, -80(%rbp)
	movq -64(%rbp), %rcx
	movq -72(%rbp), %rdi
	movq %rcx, %rsi
	call sub
	movq %rax, %rdi
	movq -80(%rbp), %rsi
	call add
	movq %rax, %rcx
	movq -32(%rbp), %rdx
	movq -24(%rbp), %rsi
	movq $1, %rax
	movq -8(%rbp), %rdi
	addq %rax, %rdi
	movq -88(%rbp), %r8
	call iter
	movq %rax, %rdi
	jmp L39
run:
	pushq %rbp
	movq %rsp, %rbp
	addq $-112, %rsp
	movq %rdi, -16(%rbp)
	movq $2, %rcx
	movq $0, %rdi
	subq %rcx, %rdi
	call of_int
	movq %rax, %rdi
	movq %rdi, -80(%rbp)
	movq -80(%rbp), %rdi
	movq $1, %rdi
	call of_int
	movq %rax, %rdi
	movq %rdi, -72(%rbp)
	movq -72(%rbp), %rcx
	movq -16(%rbp), %rcx
	movq $2, %rdi
	imulq %rcx, %rdi
	call of_int
	movq %rax, -40(%rbp)
	movq -80(%rbp), %rcx
	movq -72(%rbp), %rdi
	movq %rcx, %rsi
	call sub
	movq %rax, %rdi
	movq -40(%rbp), %rsi
	call div
	movq %rax, %rdi
	movq %rdi, -64(%rbp)
	movq -64(%rbp), %rcx
	movq $1, %rcx
	movq $0, %rdi
	subq %rcx, %rdi
	call of_int
	movq %rax, %rdi
	movq %rdi, -56(%rbp)
	movq -56(%rbp), %rdi
	movq $1, %rdi
	call of_int
	movq %rax, %rdi
	movq %rdi, -48(%rbp)
	movq -48(%rbp), %rdi
	movq -16(%rbp), %rdi
	call of_int
	movq %rax, -8(%rbp)
	movq -56(%rbp), %rdi
	movq -48(%rbp), %rcx
	movq %rdi, %rsi
	movq %rcx, %rdi
	call sub
	movq %rax, %rdi
	movq -8(%rbp), %rsi
	call div
	movq %rax, %rdi
	movq %rdi, -32(%rbp)
	movq -32(%rbp), %rdi
	movq $0, %rdi
	movq %rdi, -24(%rbp)
	movq -24(%rbp), %rdi
L132:
	movq -16(%rbp), %rdi
	movq -24(%rbp), %r15
	movq %r15, -104(%rbp)
	cmpq %rdi, -104(%rbp)
	jl L129
	movq $0, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
L129:
	movq -32(%rbp), %r15
	movq %r15, -104(%rbp)
	movq -24(%rbp), %rdi
	call of_int
	movq %rax, %rdi
	movq -104(%rbp), %rsi
	call mul
	movq %rax, %rcx
	movq -56(%rbp), %rdi
	movq %rcx, %rsi
	call add
	movq %rax, %rdi
	movq %rdi, -96(%rbp)
	movq -96(%rbp), %rdi
	movq $0, %rdi
	movq %rdi, -88(%rbp)
	movq -88(%rbp), %rcx
L118:
	movq -16(%rbp), %rcx
	movq $2, %rdi
	imulq %rcx, %rdi
	movq -88(%rbp), %r15
	movq %r15, -112(%rbp)
	cmpq %rdi, -112(%rbp)
	jl L113
	movq $10, %rdi
	call putchar
	movq %rax, %rdi
	movq $1, %rdi
	movq -24(%rbp), %rcx
	addq %rdi, %rcx
	movq %rcx, -24(%rbp)
	movq -24(%rbp), %rdi
	jmp L132
L113:
	movq -64(%rbp), %r15
	movq %r15, -112(%rbp)
	movq -88(%rbp), %rdi
	call of_int
	movq %rax, %rdi
	movq -112(%rbp), %rsi
	call mul
	movq %rax, %rcx
	movq -80(%rbp), %rdi
	movq %rcx, %rsi
	call add
	movq %rax, %rdi
	movq %rdi, %rcx
	movq -96(%rbp), %rcx
	movq %rcx, %rsi
	call inside
	movq %rax, %rdi
	cmpq $0, %rdi
	jz L101
	movq $48, %rdi
	call putchar
	movq %rax, %rdi
L97:
	movq $1, %rdi
	movq -88(%rbp), %rcx
	addq %rdi, %rcx
	movq %rcx, -88(%rbp)
	movq -88(%rbp), %rdi
	jmp L118
L101:
	movq $49, %rdi
	call putchar
	movq %rax, %rdi
	jmp L97
main:
	pushq %rbp
	movq %rsp, %rbp
	addq $0, %rsp
	movq $30, %rdi
	call run
	movq %rax, %rdi
	movq $0, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
inside:
	pushq %rbp
	movq %rsp, %rbp
	addq $-24, %rsp
	movq %rsi, -24(%rbp)
	movq %rdi, -16(%rbp)
	movq $0, %rdi
	call of_int
	movq %rax, -8(%rbp)
	movq $0, %rdi
	call of_int
	movq %rax, %rcx
	movq -24(%rbp), %rdx
	movq -16(%rbp), %rsi
	movq $0, %rdi
	movq -8(%rbp), %r8
	call iter
	movq %rax, %rdi
	movq %rdi, %rax
	movq %rbp, %rsp
	popq %rbp
	ret
	.data
