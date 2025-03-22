class LoadingSpinnerComponent < ViewComponent::Base
  erb_template <<-ERB
    <div
      class="mt-10 block mx-auto h-16 w-16 animate-spin rounded-full border-8 border-solid border-neutral-300 border-current border-e-transparent align-[-0.125em] text-surface motion-reduce:animate-[spin_1.5s_linear_infinite] dark:text-white"
      role="status">
      <span
        class="absolute! -m-px! h-px! w-px! overflow-hidden! whitespace-nowrap! border-0! p-0! [clip:rect(0,0,0,0)]!"
        >Loading...</span
      >
    </div>
  ERB
end
