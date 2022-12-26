<section>
    <header>
        <h2>
            {{ __('Delete Account') }}
        </h2>

        <p>
            {{ __('Once your account is deleted, all of its resources and data will be permanently deleted. Before deleting your account, please download any data or information that you wish to retain.') }}
        </p>
    </header>


    <form method="post" action="{{ route('profile.destroy') }}">
        @csrf
        @method('delete')

        <h2>
            {{ __('Are you sure you want to delete your account?') }}
        </h2>

        <p>
            {{ __('Once your account is deleted, all of its resources and data will be permanently deleted. Please enter your password to confirm you would like to permanently delete your account.') }}
        </p>

        <div>
            <x-input-label for="password" value="Password"/>

            <x-text-input
                id="password"
                name="password"
                type="password"
                placeholder="Password"
            />

            <x-input-error :messages="$errors->userDeletion->get('password')"/>
        </div>

        <div>
            <x-secondary-button>
                {{ __('Cancel') }}
            </x-secondary-button>

            <x-danger-button>
                {{ __('Delete Account') }}
            </x-danger-button>
        </div>
    </form>

</section>
