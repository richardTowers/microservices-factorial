namespace dotnet_core

open Microsoft.AspNetCore
open Microsoft.AspNetCore.Hosting
open Microsoft.AspNetCore.Builder
open Microsoft.AspNetCore.Http
open Microsoft.Extensions.DependencyInjection
open System.Net.Http

module Program =
    let http = new HttpClient()
    let httpGetInt (url:string) = http.GetAsync(url).Result.Content.ReadAsStringAsync().Result |> int

    let base' ()     = httpGetInt "http://base-factorial.apps.internal:8080/"
    let factorial' n = httpGetInt ("http://factorial.apps.internal:8080/" + (string n))

    let factorial n =
        match n with
        | 0 -> base' ()
        | n -> n * factorial' (n - 1)

    type Startup() =
        member this.ConfigureServices(services: IServiceCollection) = ()
        member this.Configure(app: IApplicationBuilder, env: IHostingEnvironment) =
            app.Run(fun context ->
                let mutable i = 0
                if System.Int32.TryParse(context.Request.Path.Value.Trim('/'), &i) && i >= 0
                then context.Response.WriteAsync(i |> factorial |> string)
                else context.Response.WriteAsync("ERROR")
            ) |> ignore

    [<EntryPoint>]
    let main args =
        WebHost.CreateDefaultBuilder(args).UseStartup<Startup>().Build().Run()
        0
