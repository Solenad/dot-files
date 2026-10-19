<script lang="ts">
  import { onMount } from "svelte";
  import * as zebar from "zebar";
  import type {
    BatteryOutput,
    CpuOutput,
    GlazeWmOutput,
    MemoryOutput,
    DateOutput,
    NetworkOutput,
    WeatherOutput,
    MediaOutput
  } from "zebar";

  import "../app.css";
  import Group from "../components/Group.svelte";
  import LeftGroup from "../components/LeftGroup.svelte";
  import RightGroup from "../components/RightGroup.svelte";
  import Workspaces from "../components/Workspaces.svelte";
  import MediaGroup from "../components/MediaGroup.svelte";

  let battery = $state<BatteryOutput | null>();
  let cpu = $state<CpuOutput | null>();
  let date = $state<DateOutput | null>();
  let glazewm = $state<GlazeWmOutput | null>();
  let memory = $state<MemoryOutput | null>();
  let network = $state<NetworkOutput | null>();
  let weather = $state<WeatherOutput | null>();
  let media = $state<MediaOutput | null>();

  onMount(() => {
    const providers = zebar.createProviderGroup({
      battery: { type: "battery" },
      cpu: { type: "cpu" },
      date: { type: "date", formatting: "MMM d, hh:mm a" },
      glazewm: { type: "glazewm" },
      memory: { type: "memory" },
      network: { type: "network" },
      weather: { type: "weather" },
      media: { type: "media" }
    });

    providers.onOutput(() => {
      battery = providers.outputMap.battery;
      cpu = providers.outputMap.cpu;
      date = providers.outputMap.date;
      glazewm = providers.outputMap.glazewm;
      memory = providers.outputMap.memory;
      network = providers.outputMap.network;
      weather = providers.outputMap.weather;
      media = providers.outputMap.media;
    });
  });
</script>

<div
  class="grid grid-cols-[1fr_auto_1fr] items-center h-bar w-full bg-[var(--ctp-macchiatto-mantle)] text-zb-text text-zb-size font-base px-4 pt-[10px] backdrop-blur-sm"
>
  <Group class="justify-self-start">
    <LeftGroup battery={battery!} cpu={cpu!} memory={memory!} />
  </Group>
  <Group class="justify-self-center min-w-0">
    <Workspaces glazewm={glazewm!} />
  </Group>
  <Group class="justify-self-end gap-5 whitespace-nowrap">
    <MediaGroup media={media!} />

    <RightGroup
      date={date!}
      glazewm={glazewm!}
      network={network!}
      weather={weather!}
    />
  </Group>
</div>
