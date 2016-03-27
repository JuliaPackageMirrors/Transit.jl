  import JSON

  type Emitter
    io::IO
    cache::Cache
  end

  function make_emitter(io, verbose::Bool)
    let cache = verbose ? RollingCache() : NoopCache()
      Emitter(io, cache)
    end
  end

  function emit_raw(e::Emitter, s::AbstractString)
    print(e.io, s)
  end

  function emit_tag(e::Emitter, x::AbstractString)
    emit(e, "~$x", true)
  end

  function emit(e::Emitter, x::AbstractString, cacheable::Bool)
    if iscacheable(x, cacheable)
      x = write!(e.cache, x)
    end
    print(e.io, JSON.json(x))
  end

  function emit(e::Emitter, x::Integer)
    print(e.io, JSON.json(x))
  end

  function emit_null(e::Emitter, askey::Bool)
    askey ? emit_tag(e, "_") : emit_raw(e, "null")
  end

  function emit_array_start(e::Emitter)
    print(e.io, "[")
  end

  function emit_array_end(e::Emitter)
    print(e.io, "] ")
  end

  function emit_array_sep(e::Emitter, i=2)
    if i != 1
      print(e.io, ", ")
    end
  end
