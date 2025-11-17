# Given build
# I'm not going to make you all fight with compiling go
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN go build -o server .

# Step 2: Run
FROM alpine:3.20
# DONE: 
# set WORKDIR to /app
WORKDIR /app

# copy built binary from builder
COPY --from=builder /app/server /app/server

# expose port 8080
EXPOSE 8080

# run server
CMD ["./server"]