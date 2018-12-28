class FunctionHelper
{
    static TResult Function(T) memoize<T,TResult>(TResult Function(T) operation) 
    {      
        if (operation == null) {
          throw new ArgumentError('operation is null');
        }   
        var d = new Map<T,TResult>();
        return (args)
        {
            if (d.containsKey(args))
            {
              return d[args];
            }
            var result = operation(args);
            d[args] = result;
            return result;
        };
    }
}