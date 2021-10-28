<?php

namespace App\Http\Middleware;

use Illuminate\Http\Request;

class CacheHeaders
{

    /**
     * @param  Request  $request
     * @param $next
     *
     * @return mixed
     */
    public function handle($request, $next)
    {
        if ($request->ajax() || app()->environment() == 'local') {
            return $next($request);
        }

        $age = 86400;

        return $next($request)->withHeaders([
            "Cache-Control" => "max-age=$age, public, no-transform",
        ]);
    }

}
