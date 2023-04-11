<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Support\Facades\App;

class ClearCache extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'volkv:cache {--noide}';


    /**
     * Create a new command instance.
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return mixed
     */
    public function handle()
    {
        $this->execShellWithPrettyPrint('composer dump-autoload -o');
        $this->execShellWithPrettyPrint('php artisan cache:clear');
        $this->execShellWithPrettyPrint('php artisan route:clear');
        $this->execShellWithPrettyPrint('php artisan view:clear');
        $this->execShellWithPrettyPrint('php artisan config:clear');

        if (App::environment() == 'local') {
            if (!$this->option('noide')){
                $this->execShellWithPrettyPrint('php artisan ide-helper:generate');
                $this->execShellWithPrettyPrint('php artisan ide-helper:models -W');
                $this->execShellWithPrettyPrint('php artisan ide-helper:meta');
            }

        } else {
            $this->execShellWithPrettyPrint('php artisan view:cache');
            $this->execShellWithPrettyPrint('php artisan route:cache');
            $this->execShellWithPrettyPrint('php artisan config:cache');
        }

        if (config('app.php_opcache_enable')) {
            $this->execShellWithPrettyPrint('php artisan opcache:clear');
        }

        return "Cache cleared";
    }

    /**
     * Exec shell with pretty print.
     *
     * @param  string  $command
     *
     * @return mixed
     */
    public function execShellWithPrettyPrint($command)
    {
        $this->info('---');
        $this->info($command);
        $output = shell_exec($command);
        $this->info($output);
        $this->info('---');
    }
}
