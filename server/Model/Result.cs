namespace server.Model
{
    public class Result
    {
        public bool IsFailure => string.IsNullOrWhiteSpace(Error);
        public bool IsSuccess => !IsFailure;
        public string Error { get; private set; }

        public Result(string error) => Error = error;

        public static Result Failure(string error) => new Result(error);

        internal static Result SuccessIf(bool isSuccess, string error) => Failure(isSuccess ? null : error);
    }

    public class Result<T> : Result
    {
        public T Value { get; private set; }

        public Result(T value) : base(null) => Value = value;

        public Result(string error) : base(error) => Value = default;

        public static Result<T> Success(T value) => new Result<T>(value);

        public static new Result<T> Failure(string error) => new Result<T>(error);
    }
}
